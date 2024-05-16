unit uConfigTags;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, ZAbstractTable,
  ZDataset, DB, ZAbstractRODataset, ZAbstractDataset;

type
  TfrConfigTags = class(TForm)
    GroupBox2: TGroupBox;
    edNome: TLabeledEdit;
    edValor: TLabeledEdit;
    SpeedButton1: TSpeedButton;
    GroupBox3: TGroupBox;
    dbgConfig: TDBGrid;
    qConfig: TZQuery;
    tConfig: TZTable;
    dsConfig: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    procedure save;
  public
    { Public declarations }
  end;

var
  frConfigTags: TfrConfigTags;



implementation

uses uData;


{$R *.dfm}

procedure TfrConfigTags.save;
var
  nome, valor:string;
begin
  nome:=edNome.Text;
  valor:=edValor.Text;

    qConfig.close;
    qConfig.SQL.Text:='';
    qConfig.SQL.Text:=('INSERT INTO config_tags (id, nome, valor)'+
    ' VALUES(:id, :nome, :valor )');
    qConfig.ParamByName('id').AsString:='null';
    qConfig.ParamByName('nome').AsString:=nome;
    qConfig.ParamByName('valor').AsString:=valor;
    qConfig.ExecSQL;
    qConfig.Close;
    if qConfig.RowsAffected >0 then
      tConfig.Refresh;

end;

procedure TfrConfigTags.FormShow(Sender: TObject);
begin
  tConfig.TableName:='config_tags';
  tConfig.Active:=true;
end;

procedure TfrConfigTags.SpeedButton1Click(Sender: TObject);
begin
  save
end;

end.
