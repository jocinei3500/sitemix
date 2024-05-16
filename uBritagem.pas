unit uBritagem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ZAbstractConnection, ZConnection, ZAbstractTable, ZDataset, DB,
  ZAbstractRODataset, ZAbstractDataset, ExtCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdModBusClient, Grids,
  DBGrids, StdCtrls, pngimage, connectionThreadUnit, jpeg;

type
  TfrBritagem = class(TForm)
    timer1: TTimer;
    qProd: TZQuery;
    mctPLC: TIdModBusClient;
    Label16: TLabel;
    Shape1: TShape;
    Label14: TLabel;
    Shape2: TShape;
    Shape3: TShape;
    Label18: TLabel;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Shape12: TShape;
    Shape13: TShape;
    Shape14: TShape;
    Image2: TImage;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Shape15: TShape;
    Shape16: TShape;
    Shape17: TShape;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Shape18: TShape;
    Label4: TLabel;
    Shape19: TShape;
    Label12: TLabel;
    Shape20: TShape;
    Label13: TLabel;
    edProdPo: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit9: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit19: TEdit;
    Edit20: TEdit;
    Edit21: TEdit;
    Edit22: TEdit;
    Edit23: TEdit;
    Shape21: TShape;
    Shape22: TShape;
    Shape23: TShape;
    Shape24: TShape;
    Label17: TLabel;
    Label30: TLabel;
    Edit28: TEdit;
    edEnergiaBritagem: TEdit;
    Edit30: TEdit;
    Edit31: TEdit;
    edEnergiaUsina: TEdit;
    Edit25: TEdit;
    Edit26: TEdit;
    Edit27: TEdit;
    zConnectRemote: TZConnection;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    procedure saveTagsToBase;
    function DatabaseConnect:boolean;
    procedure buscaConfig;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frBritagem: TfrBritagem;
  po, pedrisco, pedra34, pedra2, energia_usina,energia_britagem:integer;
  modBusHost:string;
  intervalo_clp_britagem:integer;

implementation

uses uData;

{$R *.dfm}



procedure TfrBritagem.saveTagsToBase;
  var
    Data: array[0..4096] of Word;
    dPo, dPedrisco,dpedra34, dPedra2, dEnergiaUsina,dEnergiaBritagem:string;
    date, hora:string;
begin
    if mctPLC.ReadHoldingRegisters(po,1, Data)then
    begin
      dPo:=IntToStr(Data[0]);
      edProdPo.Text:=dPo;
    end;
    if mctPLC.ReadHoldingRegisters(energia_britagem,1, Data)then
    begin
      dEnergiaBritagem:=IntToStr(Data[0]);
      edEnergiaBritagem.Text:=denergiaBritagem;
    end;

    qProd.close;
    qProd.SQL.Text:='';
    qProd.SQL.Text:=('INSERT INTO producao_britagem (id, pedrisco,pedra,'+
    ' po,energia_usina, energia_britagem, date, hora)'+
    ' VALUES(:id, :pedrisco, :pedra, :po, :energia_usina, :energia_britagem, :date, :hora)');
    qProd.ParamByName('id').AsString:='null';
    qProd.ParamByName('pedrisco').AsString:=dPedrisco;
    qProd.ParamByName('pedra').AsString:=dPedra34;
    qProd.ParamByName('po').AsString:=dPo;
    qProd.ParamByName('energia_usina').AsString:=dEnergiaUsina;
    qProd.ParamByName('energia_britagem').AsString:=dEnergiaBritagem;
    qProd.ParamByName('date').AsString:=date;
    qProd.ParamByName('hora').AsString:=hora;
    qProd.ExecSQL;
    qProd.Close;
end;

procedure TfrBritagem.FormShow(Sender: TObject);
begin
frBritagem.Top:=98;
frBritagem.left:=-5;
frBritagem.Width:=1610;
frBritagem.Height:=767;


buscaConfig;
if databaseConnect=false then
  exit;
timer1.Enabled:=true;

end;



procedure TfrBritagem.timer1Timer(Sender: TObject);
begin
saveTagsToBase;
end;

procedure TfrBritagem.FormClose(Sender: TObject; var Action: TCloseAction);
begin
timer1.Enabled:=false;
  zConnectRemote.Connected:=false;
end;




function TfrBritagem.DatabaseConnect:boolean;
 var
    path:string;
begin
  result:=false;
  zConnectRemote.Protocol:='mariadb';
  path:=extractFilePath(application.ExeName)+'data\libmaria\libmariadb.dll';
  zConnectRemote.LibraryLocation:=path;
  zConnectRemote.Port:=3306;

 { zConnectRemote.HostName:='localhost';
  zConnectRemote.Database:='bresola';
  zConnectRemote.Catalog:='bresola';
  zConnectRemote.User:='root';
  zConnectRemote.Password:=''; }

  zConnectRemote.HostName:='154.56.48.204';
  zConnectRemote.Database:='u528171766_dbmaxis';
  zConnectRemote.Catalog:='u528171766_dbmaxis';
  zConnectRemote.User:='u528171766_jocinei';
  zConnectRemote.Password:='By9$strings';
  try
    zConnectRemote.Connected:=true;
    if zConnectRemote.Connected=true then
      result:=true;
    mctPLC.Host := modBusHost;
  except
    showmessage('Não foi possível conectar ao banco de dados!');
    result:=false;
  end;

end;



procedure TfrBritagem.buscaConfig;
begin
  dmData.zQueryX.Close;
  dmData.zQueryX.SQL.Text:='SELECT * FROM config_tags where nome = :nome';
  dmData.zQueryX.ParamByName('nome').AsString := 'po'; // Define o valor do parâmetro ":id"
  dmData.zQueryX.Open;
  po:= dmData.zQueryX.FieldByName('valor').AsInteger;

  dmData.zQueryX.Close;
  dmData.zQueryX.SQL.Text:='SELECT * FROM config_tags where nome = :nome';
  dmData.zQueryX.ParamByName('nome').AsString := 'pedrisco'; // Define o valor do parâmetro ":id"
  dmData.zQueryX.Open;
  pedrisco:= dmData.zQueryX.FieldByName('valor').AsInteger;

  dmData.zQueryX.Close;
  dmData.zQueryX.SQL.Text:='SELECT * FROM config_tags where nome = :nome';
  dmData.zQueryX.ParamByName('nome').AsString := 'pedra34'; // Define o valor do parâmetro ":id"
  dmData.zQueryX.Open;
  pedra34:= dmData.zQueryX.FieldByName('valor').AsInteger;

  dmData.zQueryX.Close;
  dmData.zQueryX.SQL.Text:='SELECT * FROM config_tags where nome = :nome';
  dmData.zQueryX.ParamByName('nome').AsString := 'pedra2'; // Define o valor do parâmetro ":id"
  dmData.zQueryX.Open;
  pedra2:= dmData.zQueryX.FieldByName('valor').AsInteger;

  dmData.zQueryX.Close;
  dmData.zQueryX.SQL.Text:='SELECT * FROM config_tags where nome = :nome';
  dmData.zQueryX.ParamByName('nome').AsString := 'energia_usina'; // Define o valor do parâmetro ":id"
  dmData.zQueryX.Open;
  energia_usina:= dmData.zQueryX.FieldByName('valor').AsInteger;
  dmData.zQueryX.Close;

  dmData.zQueryX.SQL.Text:='SELECT * FROM config_tags where nome = :nome';
  dmData.zQueryX.ParamByName('nome').AsString := 'energia_britagem'; // Define o valor do parâmetro ":id"
  dmData.zQueryX.Open;
  energia_britagem:= dmData.zQueryX.FieldByName('valor').AsInteger;
  dmData.zQueryX.Close;

  dmData.zQueryX.SQL.Text:='SELECT * FROM config_tags where nome = :nome';
  dmData.zQueryX.ParamByName('nome').AsString := 'host_britagem'; // Define o valor do parâmetro ":id"
  dmData.zQueryX.Open;
  modBusHost:= dmData.zQueryX.FieldByName('valor').AsString;
  dmData.zQueryX.Close;

  dmData.zQueryX.SQL.Text:='SELECT * FROM config_tags where nome = :nome';
  dmData.zQueryX.ParamByName('nome').AsString := 'intervalo_busca_clp'; // Define o valor do parâmetro ":id"
  dmData.zQueryX.Open;
  intervalo_clp_britagem:= dmData.zQueryX.FieldByName('valor').AsInteger;
  dmData.zQueryX.Close;
end;

procedure TfrBritagem.Button1Click(Sender: TObject);
begin
  if databaseConnect=false then
  exit;
  saveTagsToBase;
end;

end.
