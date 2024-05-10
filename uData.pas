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
    showmessage('Não foi possível conectar ao banco de dados!');
    result:=false;
  end;
end;

procedure TdmData.DataModuleCreate(Sender: TObject);
begin
  databaseConnect;
end;

end.
