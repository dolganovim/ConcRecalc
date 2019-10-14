unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, UlkJSON, UConcRecalc;

type
  TForm1 = class(TForm)
    IdHTTP1: TIdHTTP;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  Json: string;
  sResponse: string;
  JsonToSend: TStringStream;
  JsonF, f, js: TlkJSONobject;
begin
  JsonF:= TlkJSONobject.Create();
  f:= TlkJSONobject.Create();
  f.Add('Id','CH4');
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

procedure TForm1.Button2Click(Sender: TObject);
var
  c: TRecalcConc;
  InputStr: TlkJSONobject;
begin
  c:= TRecalcConc.Create;
  InputStr:= TlkJSONobject.Create;
  InputStr.Add('Id', 'C5H12');
  c.GetOutputJSON(InputStr);
  c.Free;

end;

end.
