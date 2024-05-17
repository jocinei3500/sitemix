unit uBuscaParceiro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls;

type
  TfrBuscaParceiro = class(TForm)
    edBuscaParceiro: TEdit;
    Label1: TLabel;
    dbgParceiros: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure edBuscaParceiroChange(Sender: TObject);
    procedure dbgParceirosDblClick(Sender: TObject);
    procedure edBuscaParceiroKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgParceirosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure buscaParceiro;
    procedure selectParceiro;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frBuscaParceiro: TfrBuscaParceiro;

implementation

uses
  uData, uFrPesagem;

{$R *.dfm}

procedure TfrBuscaParceiro.buscaParceiro;
begin
  dmData.zQueryX.Close;
  dmData.zQueryX.SQL.Text:='SELECT ID, NOME FROM PARCEIROS WHERE NOME LIKE :parceiro';
  dmData.zQueryX.ParamByName('parceiro').AsString:=edBuscaParceiro.Text + '%';
  dmData.zQueryX.Open;
  dbgParceiros.Columns[0].FieldName:='id';
  dbgParceiros.Columns[1].FieldName:='nome';

end;

procedure TfrBuscaParceiro.FormShow(Sender: TObject);
begin
  edBuscaParceiro.SetFocus;
  edBuscaParceiro.Clear;
  dmData.zQueryX.Close;
  dmData.zQueryX.SQL.Text:='SELECT ID, NOME FROM PARCEIROS';
  dmData.zQueryX.Open;
  dbgParceiros.Columns[0].FieldName:='id';
  dbgParceiros.Columns[1].FieldName:='nome';

end;



procedure TfrBuscaParceiro.edBuscaParceiroChange(Sender: TObject);
begin
  buscaParceiro;
end;

procedure TfrBuscaParceiro.dbgParceirosDblClick(Sender: TObject);
begin
  selectParceiro;

end;

procedure TfrBuscaParceiro.edBuscaParceiroKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
// Verifica se a tecla pressionada é a seta para baixo
  if Key = VK_DOWN then
  begin
    // Define o foco para o DBGrid
    dbgParceiros.SetFocus;
  end else if key= VK_ESCAPE then
    close;

end;

procedure TfrBuscaParceiro.selectParceiro;
var
  id:integer;
begin
  id := dbgParceiros.DataSource.DataSet.FieldByName('id').AsInteger;
  dmData.qParceiro.Close;
  dmData.qParceiro.SQL.Text:='SELECT * FROM PARCEIROS WHERE id = :id';
  dmData.qParceiro.ParamByName('id').AsInteger := id; // Define o valor do parâmetro ":id"
  dmData.qParceiro.Open;
  frPesagem.edCodParceiro.Text:= IntToStr(dmData.qParceiro.FieldByName('id').AsInteger);
  frPesagem.edNomeParceiro.Text:= dmData.qParceiro.FieldByName('nome').AsString;
  frPesagem.edEndereco.Text:= dmData.qParceiro.FieldByName('endereco').AsString;
  frPesagem.edMunicipio.Text:= dmData.qParceiro.FieldByName('municipio').AsString;
  frPesagem.edCodProduto.SetFocus;
  close;


end;

procedure TfrBuscaParceiro.dbgParceirosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 // Verifica se a tecla pressionada é a tecla Enter
  if Key = VK_RETURN then
  begin
    // Define o foco para o DBGrid
    selectParceiro;
  end else if key= VK_ESCAPE then
    close;
end;

end.
