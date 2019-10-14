unit UConcRecalc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, UlkJSON;

  type
    TArrOfDouble = array of double;
    TRecalcConc = class

      private
        _Mass: TArrOfDouble;
        IdHTTP1: TIdHTTP;
        function ToMass(InputStr: TlkJSONObject): TArrOfDouble;
        function ToOutTypeConc(InputStr: TlkJSONObject): TlkJSONObject;

      public
        constructor Create;
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

var
  Form: TForm;
implementation

{ TRecalcConc }

constructor TRecalcConc.Create;
begin
  IdHTTP1:= TIdHTTP.Create(Form);
end;

function TRecalcConc.GetOutputJSON(InputStr: TlkJSONObject): TlkJSONObject;
var
  Json: string;
  sResponse: string;
  JsonToSend: TStringStream;
  JsonF, f, js: TlkJSONobject;
begin

  JsonF:= TlkJSONobject.Create();
  f:= TlkJSONobject.Create();
  f.Add('Id',InputStr.getString('Id'));
  f.Add('applicationPassword','1212332');
  f.Add('accountId','312324');
  f.Add('userId','535453');
  JsonF.Add('sub', f);
  Json :=TlkJSON.GenerateText(JsonF);

  //memoRequest.Text := Json;

  JsonToSend := TStringStream.Create(Utf8Encode(Json)); // D2007 and earlier only
  //in D2009 and later, use this instead:
  //JsonToSend := TStringStream.Create(Json, TEncoding.UTF8);
  try
    idHTTP1.Request.ContentType := 'application/json';
    //idHTTP1.Request.CharSet := 'utf-8';

    try
      sResponse := idHTTP1.Post('http://dolganov.tk/json.php', JsonToSend);
    except
      on E: Exception do
        ShowMessage('Error on request: '#13#10 + e.Message);
    end;
    delete(sResponse, 1, pos('{',sResponse)-1);
    js := TlkJSON.ParseText(sResponse) as TlkJSONobject;
    showmessage(js.getString('RackettZraValue'));
  finally
    JsonToSend.Free;
    //f.Free;
    JsonF.Free;
  end;

  //memoResponse.Text := sResponse;
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
