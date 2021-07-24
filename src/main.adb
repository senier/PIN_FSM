with RFLX.RFLX_Types;
with RFLX.PIN_FSM.Authentication;

package body Main is

   function User_Has_Data return Boolean
   is
   begin
      return False;
   end User_Has_Data;

   procedure User_Read (Buffer : out RFLX.RFLX_Types.Bytes;
                        Length : out RFLX.RFLX_Types.Length)
   is
   begin
      null;
   end User_Read;

   function Conf_Has_Data return Boolean is (True);

   procedure Conf_Read (Buffer : out RFLX.RFLX_Types.Bytes;
                        Length : out RFLX.RFLX_Types.Length)
   is
   begin
      null;
   end Conf_Read;

   procedure Upstream_Write (Buffer : RFLX.RFLX_Types.Bytes)
   is
   begin
      null;
   end Upstream_Write;

   package FSM is new RFLX.PIN_FSM.Authentication
      (User_Channel_Has_Data   => User_Has_Data,
       User_Channel_Read       => User_Read,
       Config_Channel_Has_Data => Conf_Has_Data,
       Config_Channel_Read     => Conf_Read,
       Upstream_Channel_Write  => Upstream_Write) with
      Unreferenced;

   procedure Run is
   begin
      raise Program_Error with "Not implemented";
   end Run;

end Main;
