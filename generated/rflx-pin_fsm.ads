--
--  Generated by RecordFlux 0.5.0-pre on 2021-07-25
--
--  Copyright (C) 2018-2021 Componolit GmbH
--
--  This file is distributed under the terms of the GNU Affero General Public License version 3.
--

pragma Style_Checks ("N3aAbcdefhiIklnOprStux");
pragma Warnings (Off, "redundant conversion");

package RFLX.PIN_FSM with
  SPARK_Mode
is

   type PIN is mod 2**64 with
     Size =>
       64;

   pragma Warnings (Off, "unused variable ""Val""");

   pragma Warnings (Off, "formal parameter ""Val"" is not referenced");

   function Valid (Val : RFLX.PIN_FSM.PIN) return Boolean is
     (True);

   pragma Warnings (On, "formal parameter ""Val"" is not referenced");

   pragma Warnings (On, "unused variable ""Val""");

   function To_Base (Val : RFLX.PIN_FSM.PIN) return RFLX.PIN_FSM.PIN is
     (Val);

   function To_Actual (Val : RFLX.PIN_FSM.PIN) return RFLX.PIN_FSM.PIN is
     (Val)
    with
     Pre =>
       Valid (Val);

   type Kind_Base is mod 2**8;

   type Kind is (Auth, Deauth, Forward, Change) with
     Size =>
       8;
   for Kind use (Auth => 1, Deauth => 2, Forward => 3, Change => 4);

   function Valid (Val : RFLX.PIN_FSM.Kind_Base) return Boolean is
     ((case Val is
          when 1 | 2 | 3 | 4 =>
             True,
          when others =>
             False));

   function To_Base (Enum : RFLX.PIN_FSM.Kind) return RFLX.PIN_FSM.Kind_Base is
     ((case Enum is
          when Auth =>
             1,
          when Deauth =>
             2,
          when Forward =>
             3,
          when Change =>
             4));

   pragma Warnings (Off, "unreachable branch");

   function To_Actual (Val : RFLX.PIN_FSM.Kind_Base) return RFLX.PIN_FSM.Kind is
     ((case Val is
          when 1 =>
             Auth,
          when 2 =>
             Deauth,
          when 3 =>
             Forward,
          when 4 =>
             Change,
          when others =>
             raise Program_Error))
    with
     Pre =>
       Valid (Val);

   pragma Warnings (On, "unreachable branch");

   type Retries_Base is mod 2**8 with
     Annotate =>
       (GNATprove, No_Wrap_Around);

   type Retries is range 0 .. 6 with
     Size =>
       8;

   function Valid (Val : RFLX.PIN_FSM.Retries_Base) return Boolean is
     (Val <= 6);

   function To_Base (Val : RFLX.PIN_FSM.Retries) return RFLX.PIN_FSM.Retries_Base is
     (RFLX.PIN_FSM.Retries_Base (Val));

   function To_Actual (Val : RFLX.PIN_FSM.Retries_Base) return RFLX.PIN_FSM.Retries is
     (RFLX.PIN_FSM.Retries (Val))
    with
     Pre =>
       Valid (Val);

end RFLX.PIN_FSM;
