unit uCadProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, DBCtrls;

type
  TfrCadProduto = class(TForm)
    gbmain: TGroupBox;
    gbdadosCad: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edCod: TEdit;
    edProduto: TEdit;
    edCodSerie: TEdit;
    edUnidade: TEdit;
    edValUnit: TEdit;
    dblMarca: TDBLookupComboBox;
    GroupBox1: TGroupBox;
    DBGrid2: TDBGrid;
    gbControles: TGroupBox;
    btnRetornar: TBitBtn;
    btnOK: TBitBtn;
    BitBtn1: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frCadProduto: TfrCadProduto;

implementation
uses
  uData;

{$R *.dfm}

end.
