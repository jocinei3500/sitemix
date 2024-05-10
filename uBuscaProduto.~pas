unit uBuscaProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls;

type
  TfrBuscaProduto = class(TForm)
    Label1: TLabel;
    edBuscaParceiro: TEdit;
    dbgProdutos: TDBGrid;
    procedure FormShow(Sender: TObject);
  private
    procedure buscaProdutos;
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
  dmData.zQueryX.Close;
  dmData.zQueryX.SQL.Text:='SELECT ID, NOME FROM PARCEIROS WHERE NOME LIKE :parceiro';
  dmData.zQueryX.ParamByName('parceiro').AsString:=edBuscaParceiro.Text + '%';
  dmData.zQueryX.Open;
  dbgProdutos.Columns[0].FieldName:='id';
  dbgProdutos.Columns[1].FieldName:='nome';

end;

procedure TfrBuscaProduto.FormShow(Sender: TObject);
begin
  edBuscaParceiro.SetFocus;
  edBuscaParceiro.Clear;
  dmData.qBusca.close;
  dmData.qBusca.SQL.Text:='SELECT ID, NOME FROM PRODUTOS';
  dmData.qBusca.Open;
  dbgProdutos.Columns[0].FieldName:='id';
  dbgProdutos.Columns[1].FieldName:='nome';
end;

end.
