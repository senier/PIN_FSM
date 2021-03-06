--
--  Generated by RecordFlux 0.5.0-pre on 2021-07-25
--
--  Copyright (C) 2018-2021 Componolit GmbH
--
--  This file is distributed under the terms of the GNU Affero General Public License version 3.
--

pragma Style_Checks ("N3aAbcdefhiIklnOprStux");

package RFLX.RFLX_Builtin_Types with
  SPARK_Mode
is

   type Length is new Natural;

   type Index is new Length range 1 .. Length'Last;

   type Byte is mod 2**8;

   type Bytes is array (Index range <>) of Byte;

   type Bytes_Ptr is access Bytes;

   type Bit_Length is range 0 .. Length'Last * 8;

   type Boolean_Base is mod 2;

end RFLX.RFLX_Builtin_Types;
