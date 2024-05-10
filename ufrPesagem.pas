unit ufrPesagem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CPort, ExtCtrls, Buttons;

type
  TfrPesagem = class(TForm)
    GroupBox1: TGroupBox;
    grdMovimentacao: TRadioGroup;
    GroupBox2: TGroupBox;
    edPlaca: TLabeledEdit;
    edSequencia: TLabeledEdit;
    GroupBox3: TGroupBox;
    edCodParceiro: TLabeledEdit;
    edNomeParceiro: TLabeledEdit;
    edEndereco: TLabeledEdit;
    edMunicipio: TLabeledEdit;
    GroupBox4: TGroupBox;
    edCodProduto: TLabeledEdit;
    edNomeProduto: TLabeledEdit;
    grdTipoPesagem: TRadioGroup;
    GroupBox5: TGroupBox;
    edCodMotorista: TLabeledEdit;
    edNomeMotorista: TLabeledEdit;
    edNotaFiscal: TLabeledEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    GroupBox6: TGroupBox;
    edPesoAtual: TLabeledEdit;
    edPesoBruto: TLabeledEdit;
    edPesoLiquido: TLabeledEdit;
    btPesagem: TSpeedButton;
    edCancelar: TSpeedButton;
    edObs: TMemo;
    edPesoNota: TLabeledEdit;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btPesagemClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frPesagem: TfrPesagem;

implementation

uses uGetPeso, uBuscaParceiro, uBuscaProduto;

{$R *.dfm}





procedure TfrPesagem.FormCreate(Sender: TObject);
begin
SysLocale.MiddleEast := true;
end;

procedure TfrPesagem.btPesagemClick(Sender: TObject);
begin
  frGetPeso.showModal;
end;

procedure TfrPesagem.SpeedButton2Click(Sender: TObject);
begin
  frBuscaParceiro.showModal;
end;

procedure TfrPesagem.SpeedButton1Click(Sender: TObject);
begin
  frBuscaProduto.showModal;
end;

end.
