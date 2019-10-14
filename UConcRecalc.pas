unit UConcRecalc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UlkJSON;

  type
    TArrOfDouble = array of double;
    TRecalcConc = class

      private
        _Mass: TArrOfDouble;
        function ToMass(InputStr: TlkJSONObject): TArrOfDouble;
        function ToOutTypeConc(InputStr: TlkJSONObject): TlkJSONObject;

      public
        function GetOutputJSON(InputStr: TlkJSONObject): TlkJSONObject;
      (*
        �������� ��������� JSON
        { InputComp: [1,2,3,4,5,6],    //id ���������� � ����
          InputConc: [1,1,1,1,1,1],    // ������������
          InputTypeConc: "tcMoln",     // ��� �������� ������������  tcMoln, tcMass, tcMolar, tcVol
          InputTypeConcSize: "%",     // ��� ����������� �������� ������������  %, dol
          OutputTypeConc: "tcMass",     // ��� ��������� ������������
          OutputTypeConcSize: "%",     // ��� ����������� �������� ������������  %, dol

        }

        �������� ���������� JSON
        { OutputComp: [1,2,3,4,5,6],    //id ���������� � ����
          OutputConc: [1,1,1,1,1,1],    // ������������
          OutputTypeConc: "tcMass",     // ��� ��������� ������������
          OutputTypeConcSize: "%",     // ��� ����������� �������� ������������  %, dol
        }
      *)

    end;
implementation

{ TRecalcConc }

function TRecalcConc.GetOutputJSON(InputStr: TlkJSONObject): TlkJSONObject;
begin
  //
end;

function TRecalcConc.ToMass(InputStr: TlkJSONObject): TArrOfDouble;
begin
  //
end;

function TRecalcConc.ToOutTypeConc(InputStr: TlkJSONObject): TlkJSONObject;
begin
  //
end;

end.
