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
    procedure DataModuleCreate(Sender: TObject);
  private
    function databaseConnect:boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmData: TdmData;

implementation

{$R *.dfm}

function TdmData.DatabaseConnect: boolean;
 var
    path:string;
begin
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
  except
    showmessage('Não foi possï¿½vel conectar ao banco de dados!');
    result:=false;
  end;


  zConnRemote.Protocol:='mariadb';
  path:=extractFilePath(application.ExeName)+'data\libmaria\libmariadb.dll';
  zConnRemote.LibraryLocation:=path;
  zConnRemote.Port:=3306;
  zConnRemote.HostName:='154.56.48.204';
  zConnRemote.Database:='u528171766_dbmaxis';
  zConnRemote.Catalog:='u528171766_dbmaxis';
  zConnRemote.User:='u528171766_jocinei';
  zConnRemote.Password:='By9$strings';
  try
    zConnRemote.Connected:=true;
  except
    showmessage('Não foi possível conectar ao banco de dados!');
    result:=false;
  end;
end;

procedure TdmData.DataModuleCreate(Sender: TObject);
begin
  databaseConnect;
end;

end.
