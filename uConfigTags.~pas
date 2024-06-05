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
    GroupBox3: TGroupBox;
    dbgConfig: TDBGrid;
    qConfig: TZQuery;
    tConfig: TZTable;
    dsConfig: TDataSource;
    btCadastrar: TBitBtn;
    edDescricao: TLabeledEdit;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure dbgConfigDblClick(Sender: TObject);
    procedure btCadastrarClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure save;
    procedure selectConfig;
    procedure alterar;
    procedure limpar;
  public
    { Public declarations }
  end;

var
  frConfigTags: TfrConfigTags;
  gId:integer;



implementation

uses uData, ufrPesagem, uBritagem;


{$R *.dfm}

procedure TfrConfigTags.save;
var
  nome, valor, descricao:string;
begin
  nome:=edNome.Text;
  valor:=edValor.Text;
  descricao:=edDescricao.Text;
  qConfig.close;
  qConfig.SQL.Text:='';
  qConfig.SQL.Text:=('INSERT INTO config_tags (id, nome, valor, descricao)'+
  ' VALUES(:id, :nome, :valor, :descricao )');
  qConfig.ParamByName('id').AsString:='null';
  qConfig.ParamByName('nome').AsString:=nome;
  qConfig.ParamByName('valor').AsString:=valor;
  qConfig.ParamByName('descricao').AsString:=descricao;
  qConfig.ExecSQL;
  dmData.zConnLocal.Commit;
  qConfig.Close;
  if qConfig.RowsAffected >0 then
    begin
      tConfig.Refresh;
      limpar;
    end;

end;

procedure TfrConfigTags.FormShow(Sender: TObject);
begin
  tConfig.TableName:='config_tags';
  tConfig.Active:=true;

  dbgConfig.Columns[0].FieldName:='id';
  dbgConfig.Columns[1].FieldName:='nome';
  dbgConfig.Columns[2].FieldName:='valor';
  dbgConfig.Columns[3].FieldName:='descricao';
end;

procedure TfrConfigTags.SpeedButton1Click(Sender: TObject);
begin
close;
end;

procedure TfrConfigTags.selectConfig;
  var
    id:integer;
begin
  id := dbgConfig.DataSource.DataSet.FieldByName('id').AsInteger;
  qConfig.Close;
  qConfig.SQL.Text:='SELECT * FROM CONFIG_TAGS WHERE id = :id';
  qConfig.ParamByName('id').AsInteger := id; // Define o valor do parâmetro ":id"
  qConfig.Open;
  gId:=qConfig.fieldByName('id').AsInteger;
  edNome.Text:= qConfig.FieldByName('nome').AsString;
  edValor.Text:= qConfig.FieldByName('valor').AsString;
  edDescricao.Text:= qConfig.FieldByName('descricao').AsString;
  btCadastrar.Caption:='Salvar';
  edNome.SetFocus;
end;

procedure TfrConfigTags.dbgConfigDblClick(Sender: TObject);
begin
  selectConfig;
end;

procedure TfrConfigTags.alterar;
begin
  qConfig.Close;
  qConfig.SQL.Text:='UPDATE CONFIG_TAGS SET NOME = :nome, VALOR=:valor, descricao=:descricao WHERE ID = :id ';
  qConfig.ParamByName('id').AsInteger := gId; // Define o valor do parâmetro ":id"
  qConfig.ParamByName('nome').AsString := edNome.Text;
  qConfig.ParamByName('valor').AsString := edValor.Text;
  qConfig.ParamByName('descricao').AsString := edDescricao.Text;
  qConfig.ExecSql;
  dmData.zConnLocal.Commit;

  tConfig.Refresh;
  limpar;
  btCadastrar.Caption:='Cadastrar';

end;

procedure TfrConfigTags.btCadastrarClick(Sender: TObject);
begin
  if btCadastrar.Caption='Cadastrar'then
    save
  else
    alterar;
end;

procedure TfrConfigTags.limpar;
begin
  edNome.Clear;
  edValor.Clear;
  edNome.SetFocus;
  edDescricao.Clear;
end;

procedure TfrConfigTags.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TfrConfigTags.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    action := CaFree;
  Release;
  frConfigTags:= Nil;
end;

end.
