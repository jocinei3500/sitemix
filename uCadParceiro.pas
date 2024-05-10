unit uCadParceiro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, Mask, Grids, DBGrids;

type
  TfrCadParceiro = class(TForm)
    gbmain: TGroupBox;
    gbcad: TGroupBox;
    Label2: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edNome: TEdit;
    edTelefone: TMaskEdit;
    edEndereco: TEdit;
    GroupBox1: TGroupBox;
    btnOk: TBitBtn;
    btnExcluir: TBitBtn;
    btFechar: TBitBtn;
    btnAlterar: TBitBtn;
    btnFiltro: TBitBtn;
    btnRelatorio: TBitBtn;
    dbgParceiros: TDBGrid;
    edMunicipio: TEdit;
    Label1: TLabel;
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure cadastrar;
    procedure getParceiros;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frCadParceiro: TfrCadParceiro;

implementation

uses
  uData;

{$R *.dfm}

{ TfrCadParceiro }

procedure TfrCadParceiro.cadastrar;
var
  nome,endereco,municipio,telefone:string;
begin
  nome:=edNome.Text;
  endereco:=edEndereco.Text;
  municipio:=edMunicipio.Text;
  telefone:=edTelefone.Text;

  dmData.qParceiro.SQL.Text:='';
  dmData.qParceiro.SQL.Text:=('INSERT INTO parceiros (id, nome,endereco,'+
  ' municipio,telefone)'+
  ' VALUES(:id, :nome, :endereco, :municipio,  :telefone )');
  dmData.qParceiro.ParamByName('id').AsString:='null';
  dmData.qParceiro.ParamByName('nome').AsString:=nome;
  dmData.qParceiro.ParamByName('endereco').AsString:=endereco;
  dmData.qParceiro.ParamByName('municipio').AsString:=municipio;
  dmData.qParceiro.ParamByName('telefone').AsString:=telefone;
  dmData.qParceiro.ExecSQL;
  if dmData.qParceiro.RowsAffected >0 then
    begin
      showmessage('Cadastro realizado com sucesso!');
    end;
end;

procedure TfrCadParceiro.btnOkClick(Sender: TObject);
begin
  cadastrar;
end;



procedure TfrCadParceiro.getParceiros;
begin
  dmData.tParceiro.TableName:='parceiros';
  dmData.tParceiro.Active:=true;
  dbgParceiros.Columns[0].FieldName:='razao_social';
  dbgParceiros.Columns[1].FieldName:='nome_fantasia';
  dbgParceiros.Columns[2].FieldName:='telefone';
  dbgParceiros.Columns[3].FieldName:='data_cadastro';
  dbgParceiros.Columns[4].FieldName:='contato';
end;

procedure TfrCadParceiro.FormShow(Sender: TObject);
begin
  getParceiros;
end;

end.
