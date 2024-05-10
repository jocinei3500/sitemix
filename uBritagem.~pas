unit uBritagem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ZAbstractConnection, ZConnection, ZAbstractTable, ZDataset, DB,
  ZAbstractRODataset, ZAbstractDataset, ExtCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdModBusClient, Grids,
  DBGrids, StdCtrls, pngimage, connectionThreadUnit;

type
  TfrBritagem = class(TForm)
    Image1: TImage;
    lbBrita2: TLabel;
    lbPedrisco: TLabel;
    lbPedra34: TLabel;
    lbPo: TLabel;
    lbRegisterDb: TLabel;
    Label11: TLabel;
    edProdBrita2: TEdit;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edTag1: TEdit;
    btnRead: TButton;
    edTag2: TEdit;
    edTag3: TEdit;
    edTag4: TEdit;
    edTag5: TEdit;
    edtIPAddress: TEdit;
    DBGrid1: TDBGrid;
    edProdPo: TEdit;
    edProdPedrisco: TEdit;
    edProdPedra34: TEdit;
    btConnectDatabase: TButton;
    btControllTimer: TButton;
    edInterval: TEdit;
    timer1: TTimer;
    qProd: TZQuery;
    DataSource1: TDataSource;
    tProducao: TZTable;
    zConnectRemote: TZConnection;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Button1: TButton;
    mctPLC: TIdModBusClient;
    procedure FormShow(Sender: TObject);
    procedure btConnectDatabaseClick(Sender: TObject);
    procedure btControllTimerClick(Sender: TObject);
    procedure timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    procedure saveTagsToBase;
    function DatabaseConnect:boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frBritagem: TfrBritagem;

implementation

{$R *.dfm}



procedure TfrBritagem.saveTagsToBase;
  var
    Data: array[0..4096] of Word;
    tag1, tag2, tag3, tag4, tag5:integer;
    pedrisco, pedra, po, energia_usina, energia_britagem, date, hora:string;
begin
  hora:=TimeToStr(now());
  date:=(FormatDateTime('yyyy-mm-dd', Now));
  tag1:=StrToInt(edTag1.Text);
  tag2:=StrToInt(edTag2.Text);
  tag3:=StrToInt(edTag3.Text);
  tag4:=StrToInt(edTag4.Text);
  tag5:=StrToInt(edTag5.Text);
  try
    mctPLC.ReadHoldingRegisters(tag1,1, Data);
    pedrisco:=IntToStr(Data[0]);
    edProdBrita2.Text:=pedrisco;
  except
    timer1.Enabled:=false;
    showmessage('Não foi possivel conectar ao CLP!');
    exit;
  end;
  if mctPLC.ReadHoldingRegisters(tag2,1, Data) then
    pedra:=IntToStr(Data[0]);
    edProdPedra34.Text:=pedra;
  if mctPLC.ReadHoldingRegisters(tag3,1, Data)then
    po:=IntToStr(Data[0]);
    edProdPo.Text:=po;
  if mctPLC.ReadHoldingRegisters(tag4,1, Data)then
    energia_usina:=IntToStr(Data[0]);
  if mctPLC.ReadHoldingRegisters(tag5,1, Data)then
    energia_britagem:=IntToStr(Data[0]);

    qProd.SQL.Text:='';
    qProd.SQL.Text:=('INSERT INTO producao_britagem (id, pedrisco,pedra,'+
    ' po,energia_usina, energia_britagem, date, hora)'+
    ' VALUES(:id, :pedrisco, :pedra, :po, :energia_usina, :energia_britagem, :date, :hora)');
    qProd.ParamByName('id').AsString:='null';
    qProd.ParamByName('pedrisco').AsString:=pedrisco;
    qProd.ParamByName('pedra').AsString:=pedra;
    qProd.ParamByName('po').AsString:=po;
    qProd.ParamByName('energia_usina').AsString:=energia_usina;
    qProd.ParamByName('energia_britagem').AsString:=energia_britagem;
    qProd.ParamByName('date').AsString:=date;
    qProd.ParamByName('hora').AsString:=hora;
    qProd.ExecSQL;
    qProd.Close;
    if qProd.RowsAffected >0 then
      begin
        tProducao.Refresh;
      end;
end;

procedure TfrBritagem.FormShow(Sender: TObject);
begin
frBritagem.Top:=98;
frBritagem.left:=-5;
frBritagem.Width:=1610;
frBritagem.Height:=767;
with image1 do
  begin
    top:=90;
    left:=10;
    height:=593;
    width:=1544;
  end;
end;

procedure TfrBritagem.btConnectDatabaseClick(Sender: TObject);
begin
  databaseConnect;
end;

procedure TfrBritagem.btControllTimerClick(Sender: TObject);
begin
if databaseConnect=false then
exit;
timer1.Interval:=strToInt(edInterval.Text);
  if  btControllTimer.Caption= 'Start Read' then
    begin
      timer1.Enabled:=true;
      btControllTimer.Caption:='Stop Read';
      lbRegisterDb.Visible:=true;
    end
  else
    begin
      timer1.Enabled:=false;
      btControllTimer.Caption:='Start Read';
      lbRegisterDb.Visible:=false;
    end;
  end;

procedure TfrBritagem.timer1Timer(Sender: TObject);
begin
saveTagsToBase;
end;

procedure TfrBritagem.FormClose(Sender: TObject; var Action: TCloseAction);
begin
timer1.Enabled:=false;
  tProducao.Active:=false;
  zConnectRemote.Connected:=false;
end;




function TfrBritagem.DatabaseConnect: boolean;
 var
    path:string;
begin
  zConnectRemote.Protocol:='mariadb';
  path:=extractFilePath(application.ExeName)+'data\libmaria\libmariadb.dll';
  zConnectRemote.LibraryLocation:=path;
  zConnectRemote.Port:=3306;
  zConnectRemote.HostName:='localhost';
  zConnectRemote.Database:='bresola';
  zConnectRemote.Catalog:='bresola';
  zConnectRemote.User:='root';
  zConnectRemote.Password:='';

  {zConnectRemote.HostName:='154.56.48.204';
  zConnectRemote.Database:='u528171766_dbmaxis';
  zConnectRemote.Catalog:='u528171766_dbmaxis';
  zConnectRemote.User:='u528171766_jocinei';
  zConnectRemote.Password:='By9$strings';}
  try
    zConnectRemote.Connected:=true;
    dbGrid1.Columns[0].FieldName:='id';
    dbGrid1.Columns[1].FieldName:='pedrisco';
    dbGrid1.Columns[2].FieldName:='pedra';
    dbGrid1.Columns[3].FieldName:='po';
    dbGrid1.Columns[4].FieldName:='energia_usina';
    dbGrid1.Columns[5].FieldName:='energia_britagem';
    dbGrid1.Columns[6].FieldName:='date';
    dbGrid1.Columns[7].FieldName:='hora';

    mctPLC.Host := edtIPAddress.Text;
    tProducao.TableName:='producao_britagem';
    tProducao.Active:=true;
    result:=true;
  except
    showmessage('Não foi possível conectar ao banco de dados!');
    result:=false;
  end;

end;



procedure TfrBritagem.Button1Click(Sender: TObject);
var
  ConnectionThread: TConnectionThread;
begin
  ConnectionThread := TConnectionThread.Create('192.168.3.125');
  try
    if ConnectionThread.Success then
    begin
      ShowMessage('Conexão estabelecida com sucesso.');
      // Aqui você pode adicionar código adicional para lidar com a conexão bem-sucedida
    end
    else
      ShowMessage('Não foi possível conectar ao dispositivo Modbus.');
  finally
    ConnectionThread.Free;
  end;
end;

end.
