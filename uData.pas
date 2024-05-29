unit uData;

interface

uses
  SysUtils, Classes, ZAbstractConnection, ZConnection, Forms, Dialogs,
  ZAbstractTable, ZDataset, DB, ZAbstractRODataset, ZAbstractDataset;

type
  TdmData = class(TDataModule)
    zConnLocal: TZConnection;
    qParceiro: TZQuery;
    tParceiro: TZTable;
    dsParceiro: TDataSource;
    zQueryX: TZQuery;
    dsX: TDataSource;
    qBUsca: TZQuery;
    dsProdutro: TDataSource;
    qProduto: TZQuery;
    zConnRemote: TZConnection;
    tProducao: TZTable;
    DataSource1: TDataSource;
    qProducao: TZQuery;
    qCadProdRemote: TZQuery;
    qCadProdLocal: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure zConnLocalLost(Sender: TObject);
    procedure zConnRemoteLost(Sender: TObject);
  private
    { Private declarations }
  public
  function LocalDatabaseConnect:boolean;
    function RemotedataBaseConnect: Boolean;
    { Public declarations }
  end;

var
  dmData: TdmData;


implementation

uses uBritagem;

{$R *.dfm}

function TdmData.LocalDatabaseConnect: boolean;
 var
    path:string;
begin
  result:=false;
  zConnLocal.Protocol:='mariadb';
  path:=extractFilePath(application.ExeName)+'data\libmaria\libmariadb.dll';
  zConnLocal.LibraryLocation:=path;
  zConnLocal.Port:=3306;
  zConnLocal.HostName:='localhost';
  zConnLocal.Database:='bresola';
  zConnLocal.Catalog:='bresola';
  zConnLocal.User:='root';
  zConnLocal.Password:='';
  try
    zConnLocal.Connected:=true;
    result:=true;
  except
    showmessage('Não foi possível conectar ao banco de dados!');
    result:=false;
  end;
end;

function TDmData.RemoteDataBaseConnect:Boolean;
var
  LPath:String;
begin
  result:=false;
  zConnRemote.Protocol:='mariadb';
  LPath:=extractFilePath(application.ExeName)+'data\libmaria\libmariadb.dll';
  zConnRemote.LibraryLocation:=LPath;
  zConnRemote.Port:=3306;
  zConnRemote.HostName:='154.56.48.204';
  zConnRemote.Database:='u528171766_dbmaxis';
  zConnRemote.Catalog:='u528171766_dbmaxis';
  zConnRemote.User:='u528171766_jocinei';
  zConnRemote.Password:='By9$strings';
  try
    zConnRemote.Connected:=true;
    tProducao.TableName:='producao_britagem';
    tProducao.Active:=true;
    result:=true;
  except
    showmessage('Não foi possível conectar ao banco de dados!');
    result:=false;
  end;
end;
procedure TdmData.DataModuleCreate(Sender: TObject);
begin
  LocalDatabaseConnect;
end;

procedure TdmData.zConnLocalLost(Sender: TObject);
begin
  frBritagem.tReadPlc.Enabled:=false;
  showMessage('O banco de Dados perdeu a conexão');
end;

procedure TdmData.zConnRemoteLost(Sender: TObject);
begin
  frBritagem.tReadPlc.Enabled:=false;
  zConnRemote.Disconnect;
end;

end.
