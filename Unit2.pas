{$optimization off}
unit Unit2;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,Dialogs, StdCtrls, Unit3;

type
LongArithmeticOperation = class(LongArithmetic) {extend}
public constructor Create(s_number_param: string);
public function sum(o_number_a: LongArithmeticOperation; o_number_b: LongArithmeticOperation): LongArithmeticOperation;
public function sub(o_number_a: LongArithmeticOperation; o_number_b: LongArithmeticOperation): LongArithmeticOperation;
public function multiplication(o_number_a: LongArithmeticOperation; o_number_b: LongArithmeticOperation): LongArithmeticOperation;
public function divisionDiv(o_number_a: LongArithmeticOperation; o_number_b: LongArithmeticOperation): LongArithmeticOperation;
public function divisionMod(o_number_a: LongArithmeticOperation; o_number_b: LongArithmeticOperation): LongArithmeticOperation;
end;

implementation

constructor LongArithmeticOperation.Create(s_number_param: string);
begin
  Inherited Create(s_number_param);
end;

function LongArithmeticOperation.sum(o_number_a: LongArithmeticOperation; o_number_b: LongArithmeticOperation): LongArithmeticOperation;
var
  i,i_length,i_length_difference,i_template: integer;
  a_number_a, a_number_b,a_template_a,a_template_b: TArray;
  o_result: LongArithmeticOperation;
begin
  i_template := 0;
  a_number_a := o_number_a.GetNumber();
  a_number_b := o_number_b.GetNumber();

  i_length := o_number_a.GetLengthNumber();
  i_length_difference:= o_number_a.GetLengthNumber() - o_number_b.GetLengthNumber();

  if(i_length_difference > 0) then
  begin
    a_number_b := o_result.BalanceArray(a_number_b, i_length_difference);
    i_length := o_number_a.GetLengthNumber();
  end
  else if(i_length_difference < 0) then
  begin
    a_number_a := o_result.BalanceArray(a_number_a, abs(i_length_difference));
    i_length := o_number_b.GetLengthNumber();
  end;

  setLength(a_template_a, i_length+1);
  for i:= i_length-1  downto 0 do
  begin
    i_template := i_template+a_number_a[i]+a_number_b[i];
    a_template_a[i+1] := i_template mod 10;
    i_template := i_template div 10;
  end;

  if(i_template > 0) then
    a_template_a[0] := i_template;

  a_template_a := o_result.ClearZero(a_template_a);
  o_result := LongArithmeticOperation.Create(ArrayToString(a_template_a));
  Result := o_result;
end;

function LongArithmeticOperation.sub(o_number_a: LongArithmeticOperation; o_number_b: LongArithmeticOperation): LongArithmeticOperation;
var
  i,i_length,i_length_difference,i_template,i_more: integer;
  a_number_a, a_number_b,a_template_a,a_template_b: TArray;
  o_result: LongArithmeticOperation;
  s_sign: char;
begin
  s_sign := ' ';
  i_template := 0;
  a_template_a := o_number_a.GetNumber();
  a_template_b := o_number_b.GetNumber();


  i_length_difference := o_number_a.GetLengthNumber() - o_number_b.GetLengthNumber();
  i_length := o_number_a.GetLengthNumber();
  if(i_length_difference > 0) then
  begin
    a_number_b := o_result.BalanceArray(a_template_b, i_length_difference);
    a_number_a := a_template_a;
    i_length := o_number_a.GetLengthNumber();
  end
  else if(i_length_difference < 0) then
  begin
    s_sign := '-';
    a_number_b := o_result.BalanceArray(a_template_a, abs(i_length_difference));
    a_number_a := a_template_b;
    i_length := o_number_b.GetLengthNumber();
  end
  else
  begin
    i_more:= o_result.CompLong(a_template_a,a_template_b);
    if(i_more > -1) then
    begin
      a_number_a := a_template_a;
      a_number_b := a_template_b;
    end
    else if(i_more < 0) then
    begin
      s_sign := '-';
      a_number_a := a_template_b;
      a_number_b := a_template_a;
    end;
  end;

  SetLength(a_template_a, i_length);
  for i := i_length-1 downto 0 do
  begin
    i_template := i_template + a_number_a[i] - a_number_b[i] + 10;
    a_template_a[i] := i_template mod 10;

    if(i_template < 10) then
      i_template := -1
    else
      i_template := 0;
  end;

  for i := 0 to i_length do
  begin
    if(a_template_a[i] > 0) then
    begin
      i_template := i;
      break;
    end;
  end;

  a_template_b := o_result.ClearZero(a_template_a);
  i_length := Length(a_template_b);

    o_result:= LongArithmeticOperation.Create(ArrayToString(a_template_b));
    o_result.SetSign(s_sign);
    Result := o_result;
end;

function LongArithmeticOperation.multiplication(o_number_a: LongArithmeticOperation; o_number_b: LongArithmeticOperation): LongArithmeticOperation;
var
  i,j,i_length,i_length_number_a,i_length_number_b,i_template,i_length_difference: integer;
  a_number_a, a_number_b,a_template_a,a_template_b: TArray;
  o_result: LongArithmeticOperation;
begin
  i_template := 0;
  a_number_a := o_number_a.GetNumber();
  a_number_b := o_number_b.GetNumber();
  i_length_number_b := o_number_b.GetLengthNumber();
  i_length_number_a := o_number_a.GetLengthNumber();
  SetLength(a_template_a,i_length_number_b+i_length_number_a);
  for i := i_length_number_b-1 downto 0 do
  begin
    i_template := 0;
    for j:= i_length_number_a-1 downto 0 do
    begin
      a_template_a[j + i + 1] := a_template_a[j + i + 1]+i_template + a_number_a[j] * a_number_b[i];
      i_template := a_template_a[j + i + 1] div 10;
      a_template_a[j + i + 1] := a_template_a[j + i + 1] mod 10;
    end;
    a_template_a[i] :=  i_template;
  end;

  a_template_b := o_result.ClearZero(a_template_a);
  i_length := Length(a_template_b);

  o_result:= LongArithmeticOperation.Create(ArrayToString(a_template_b));
  Result := o_result;
end;

function LongArithmeticOperation.divisionDiv(o_number_a: LongArithmeticOperation; o_number_b: LongArithmeticOperation): LongArithmeticOperation;
var
  i,j,i_length,i_length_difference,i_template,is_more,i_result: integer;
  a_number_a, a_number_b,a_template_a,a_template_b,a_template_c,a_template, b_template: TArray;
  o_result, o_template_a,o_template_b,o_template_c,o_sum,o_sub,o_template_sub: LongArithmeticOperation;
  s_result,s_number: string;
begin
  a_number_b := o_number_b.GetNumber();
  o_result.CheckDivider(a_number_b);
  a_number_a := o_number_a.GetNumber();
  a_template_b := a_number_b;

  i_length := o_number_a.GetLengthNumber();
  i_length_difference:= o_number_a.GetLengthNumber() - o_number_b.GetLengthNumber();

  if(i_length_difference < 0) then
  begin
    o_result:= LongArithmeticOperation.Create('0');
    Result := o_result;
  end
  else if(i_length_difference = 0) then
  begin
    is_more := o_result.CompLong(a_number_a,a_number_b);
    if(is_more = -1) then
    begin
      o_result:= LongArithmeticOperation.Create('0');
      Result := o_result;
    end
    else if(is_more = 0) then
    begin
      o_result:= LongArithmeticOperation.Create('1');
      Result := o_result;
    end
    else
    begin
      i := 1;
      o_template_a := o_result.sum(o_number_b,o_number_b);
      a_template_a := o_template_a.GetNumber();
      a_template_b := a_number_b;

      while(CompLong(a_number_a,a_template_a) >= 0) do
      begin
        inc(i);
        a_template_b := a_template_a;
        o_template_a := LongArithmeticOperation.Create(ArrayToString(a_template_a));

        o_sum := o_result.sum(o_number_b,o_template_a);
        i_length := o_sum.GetLengthNumber;
        if(i_length > Length(a_template_a)) then
          break;

        a_template_a := o_sum.GetNumber();
      end;

      o_result:= LongArithmeticOperation.Create(IntToStr(i));
      Result := o_result;
    end;
  end
  else
  begin
    i_length := o_number_b.GetLengthNumber();
    SetLength(a_template_a,i_length);

    for i:=0 to i_length-1 do
    begin
      a_template_a[i] := a_number_a[i];
    end;

    if(CompLong(a_template_a, a_number_b) = -1) then
    begin
      Inc(i_length);
      SetLength(a_template_a,i_length);
      for i := 0 to i_length-1 do
      begin
        a_template_a[i] := a_number_a[i];
        a_number_b := BalanceArray(a_number_b,1);
      end;
    end;

    o_template_a := LongArithmeticOperation.Create(ArrayToString(a_template_a));

    for i := i_length to Length(a_number_a) do
    begin
      s_number := '';
      i_result := 0;
      a_template_b := a_number_b;
      if(CompLong(a_template_a,a_template_b) >= 0) then
      begin
        inc(i_result);
        o_template_b := o_result.sum(o_number_b,o_number_b);
        a_template_c := a_template_b;
        o_template_c := o_number_b;
        a_template_b := o_template_b.GetNumber();
        while(CompLong(a_template_a,a_template_b) >= 0) do
        begin
          if(Length(a_template_b) > Length(a_template_a)) then
            break;

          inc(i_result);
          o_template_b := LongArithmeticOperation.Create(ArrayToString(a_template_b));
          o_template_c := o_template_b;

          o_sum := o_result.sum(o_number_b,o_template_b);
          i_length := o_sum.GetLengthNumber;

          if(i_length > Length(a_template_a)) then
            break;

          a_template_b := o_sum.GetNumber();
        end;
        o_sub := o_result.sub(o_template_a,o_template_c);
        o_template_a.Destroy();
        a_template_a := o_sub.GetNumber();
      end;
        a_template_a := o_result.ClearZero(a_template_a);
        s_number := o_result.ArrayToString(a_template_a);
        s_number := s_number + IntToStr(a_number_a[i]);
        o_template_a := LongArithmeticOperation.Create(s_number);
        a_template_a := o_template_a.GetNumber();

        i_length_difference := Length(a_template_a) - Length(a_number_b);

        if(i_length_difference > 0) then
        begin
          a_number_b := o_result.BalanceArray(a_number_b, i_length_difference);
        end
        else if(i_length_difference < 0) then
        begin
          a_number_a := o_result.BalanceArray(a_number_a, Abs(i_length_difference));
        end;

        s_result := s_result + IntToStr(i_result);
    end;

  o_result:= LongArithmeticOperation.Create(s_result);
  Result := o_result;
  end;
end;

function LongArithmeticOperation.divisionMod(o_number_a: LongArithmeticOperation; o_number_b: LongArithmeticOperation): LongArithmeticOperation;
var
  o_result,o_div,o_template: LongArithmeticOperation;
begin
   o_div := o_result.divisionDiv(o_number_a,o_number_b);
   o_template := o_result.multiplication(o_number_b,o_div);
   Result := o_result.sub(o_number_a,o_template);
end;
end.
