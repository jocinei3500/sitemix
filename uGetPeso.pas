unit uGetPeso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, CPort;

type
  TfrGetPeso = class(TForm)
    edGetPeso: TEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ComPort1: TComPort;
    procedure FormShow(Sender: TObject);
    procedure ComPort1RxChar(Sender: TObject; Count: Integer);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frGetPeso: TfrGetPeso;

implementation

uses
  ufrPesagem;

{$R *.dfm}

function retirarZeros( texto : string ): string;
begin
   while ( pos( '0', texto ) = 1) do
    begin
      texto := copy( texto, 2, length( texto ) );
    end;
    if(length(trim(texto)) =0)then
      texto:='0' ;
  result:=texto
end;

procedure TfrGetPeso.FormShow(Sender: TObject);
begin
  Comport1.Open;
  edGetPeso.Text:=frPesagem.edPesoTara.Text;
end;

procedure TfrGetPeso.ComPort1RxChar(Sender: TObject; Count: Integer);
var
  Str: String;
begin
  ComPort1.ReadStr(Str, 8);
  Str:=Copy(Str,2,length(Str));
  EdGetPeso.Text :=retirarZeros(Str);

end;



procedure TfrGetPeso.SpeedButton2Click(Sender: TObject);
begin
  close;
end;

procedure TfrGetPeso.SpeedButton1Click(Sender: TObject);
begin
  frPesagem.edPesoTara.Text:=edGetPeso.Text;
  close;
end;

end.
