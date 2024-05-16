unit uBuscaProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls;

type
  TfrBuscaProduto = class(TForm)
    Label1: TLabel;
    edBuscaProduto: TEdit;
    dbgProdutos: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure edBuscaProdutoChange(Sender: TObject);
    procedure edBuscaProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgProdutosDblClick(Sender: TObject);
    procedure dbgProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure buscaProdutos;
    procedure selectProduto;
    { private declarations }
  public
    { Public declarations }
  end;

var
  frBuscaProduto: TfrBuscaProduto;

implementation

uses uData, ufrPesagem;

{$R *.dfm}


procedure TfrBuscaProduto.buscaProdutos;
begin
  dmData.qProduto.Close;
  dmData.qProduto.SQL.Text:='SELECT ID, NOME FROM PRODUTOS WHERE NOME LIKE :produto';
  dmData.qProduto.ParamByName('produto').AsString:=edBuscaProduto.Text + '%';
  dmData.qProduto.Open;
  dbgProdutos.Columns[0].FieldName:='id';
  dbgProdutos.Columns[1].FieldName:='nome';

end;

procedure TfrBuscaProduto.FormShow(Sender: TObject);
begin
  edBuscaProduto.SetFocus;
  edBuscaProduto.Clear;
  dmData.qProduto.close;
  dmData.qProduto.SQL.Text:='SELECT ID, NOME FROM PRODUTOS';
  dmData.qProduto.Open;
  dbgProdutos.Columns[0].FieldName:='id';
  dbgProdutos.Columns[1].FieldName:='nome';
end;

procedure TfrBuscaProduto.edBuscaProdutoChange(Sender: TObject);
begin
  buscaProdutos;
end;

procedure TfrBuscaProduto.edBuscaProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
// Verifica se a tecla pressionada é a seta para baixo
  if Key = VK_DOWN then
  begin
    // Define o foco para o DBGrid
    dbgProdutos.SetFocus;
  end else if key = VK_ESCAPE then
    close;
end;

procedure TfrBuscaProduto.selectProduto;
var
  id:integer;
begin
  id := dbgProdutos.DataSource.DataSet.FieldByName('id').AsInteger;
  dmData.zQueryX.Close;
  dmData.zQueryX.SQL.Text:='SELECT * FROM PRODUTOS WHERE id = :id';
  dmData.zQueryX.ParamByName('id').AsInteger := id; // Define o valor do parâmetro ":id"
  dmData.zQueryX.Open;
  frPesagem.edCodProduto.Text:= IntToStr(dmData.zQueryX.FieldByName('id').AsInteger);

  close;

end;

procedure TfrBuscaProduto.dbgProdutosDblClick(Sender: TObject);
begin
  selectProduto;
end;

procedure TfrBuscaProduto.dbgProdutosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
// Verifica se a tecla pressionada é a tecla Enter
  if Key = VK_RETURN then
    begin
      // Define o foco para o DBGrid
      selectProduto;
    end
  else if key=VK_ESCAPE then
    close
end;

end.
