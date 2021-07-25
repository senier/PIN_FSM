with Ada.Text_IO;
with Ada.IO_Exceptions;
with RFLX.RFLX_Types;
with RFLX.PIN_FSM.Authentication;

package body Main is

   User_Done : exception;

   type Kind is (Auth, Deauth, Forward) with Size => 8;
   for Kind use (Auth => 1, Deauth => 2, Forward => 3);
   type Retries is mod 2**8 with Size => 8;
   subtype PIN is String (1 .. 8);

   type Config_Message is
   record
      Retries : Main.Retries;
      PIN     : Main.PIN;
   end record;

   Config : Config_Message := (Retries => 3, PIN => "Secure!!");

   function User_Has_Data return Boolean is (raise Program_Error with "Should be unused");

   procedure User_Read (Buffer : out RFLX.RFLX_Types.Bytes;
                        Length : out RFLX.RFLX_Types.Length)
   is
      use type RFLX.RFLX_Types.Length;
      use type RFLX.RFLX_Types.Index;
   begin
      Ada.Text_IO.Put_Line ("BLEN: " & Buffer'Length'Image);
      loop
         Ada.Text_IO.Put ("> ");
         declare
            Data : constant String := Ada.Text_IO.Get_Line;
         begin
            if
               Data'Length > 5
               and then Buffer'Length > 8
               and then Data (1 .. 5) = "AUTH "
            then
               Buffer := (others => 0);
               Buffer (1) := 1;  --  Kind = Auth
               for I in 1 .. Data'Length - 5 loop
                  Buffer (1 + RFLX.RFLX_Types.Index (I)) :=
                     RFLX.RFLX_Types.Byte (Character'Pos (Data (5 + I)));
               end loop;
               Length := 9;
               exit;
            end if;

            if
               Data'Length = 6
               and then Buffer'Length > 0
               and then Data = "DEAUTH"
            then
               Buffer (Buffer'First) := 2;  --  Kind = Deauth
               Length := 1;
               exit;
            end if;

            if
               Data'Length > 8
               and then Buffer'Length > Data'Length - 8
               and then Data (1 .. 8) = "FORWARD "
            then
               Buffer (1) := 3;  --  Kind = Forward
               for I in 2 .. Data'Length - 7 loop
                  Buffer (RFLX.RFLX_Types.Index (I)) :=
                     RFLX.RFLX_Types.Byte (Character'Pos (Data (I + 7)));
               end loop;
               Length := Data'Length - 7;
               exit;
            end if;

            Ada.Text_IO.Put_Line ("Syntax error: " & Data);
         end;
      end loop;

      Ada.Text_IO.Put_Line ("User_Read:" & RFLX.RFLX_Types.Index (Length)'Image);
   exception
      when Ada.IO_Exceptions.End_Error =>
         raise User_Done;
   end User_Read;

   function Conf_Has_Data return Boolean is (raise Program_Error with "Should be unused");

   procedure Conf_Read (Buffer : out RFLX.RFLX_Types.Bytes;
                        Length : out RFLX.RFLX_Types.Length)
   is
      Buf : RFLX.RFLX_Types.Bytes (1 .. 9) with Address => Config'Address;
   begin
      Buffer (1 .. 9) := Buf;
      Length := 9;
   end Conf_Read;

   procedure Upstream_Write (Buffer : RFLX.RFLX_Types.Bytes)
   is
      Text : String (Integer (Buffer'First) .. Integer (Buffer'Last));
   begin
      for I in Buffer'Range
      loop
         Text (Integer (I)) := Character'Val (Buffer (I));
      end loop;
      Ada.Text_IO.Put_Line ("TO UPSTREAM: " & Text);
   end Upstream_Write;

   package FSM is new RFLX.PIN_FSM.Authentication
      (User_Channel_Has_Data   => User_Has_Data,
       User_Channel_Read       => User_Read,
       Config_Channel_Has_Data => Conf_Has_Data,
       Config_Channel_Read     => Conf_Read,
       Upstream_Channel_Write  => Upstream_Write);

   procedure Run is
   begin
      FSM.Run;
   exception
      when User_Done =>
         Ada.Text_IO.Put_Line ("Exited");
   end Run;

end Main;
