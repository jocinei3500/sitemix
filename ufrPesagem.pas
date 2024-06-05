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
    edPesoTara: TLabeledEdit;
    edPesoBruto: TLabeledEdit;
    edPesoLiquido: TLabeledEdit;
    btPesagem: TSpeedButton;
    edCancelar: TSpeedButton;
    edObs: TMemo;
    edPesoNota: TLabeledEdit;
    Label1: TLabel;
    SpeedButton3: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btPesagemClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure edCodParceiroKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edPlacaExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edCodParceiroExit(Sender: TObject);
    procedure edCodProdutoExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure buscaSequencia;
    procedure buscaProduto;
    procedure buscaParceiro;
    procedure limpar;
        { Private declarations }
  public
    { Public declarations }
  end;

var
  frPesagem: TfrPesagem;

implementation

uses uGetPeso, uBuscaParceiro, uBuscaProduto, uData, uBritagem;

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

procedure TfrPesagem.edCodParceiroKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_DOWN then
    begin
      frBuscaParceiro.ShowModal;
    end;
end;

procedure TfrPesagem.edCodProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);

begin
  if key= VK_DOWN then
    frBuscaProduto.ShowModal;
end;

procedure TfrPesagem.buscaSequencia;
  var
    sequencia:integer;
begin
  dmData.zQueryX.Close;
  dmData.zQueryX.SQL.Text := 'SELECT MAX(SEQUENCIA) AS SEQUENCIA FROM PESAGEM WHERE PLACA = :parceiro';
  dmData.zQueryX.ParamByName('parceiro').AsString := edPlaca.Text;
  dmData.zQueryX.Open;

  // Verifica se a consulta trouxe algum registro
  if not dmData.zQueryX.IsEmpty then
    begin
      sequencia:= dmData.zQueryX.FieldByName('sequencia').AsInteger;
      if sequencia=0 then
        frPesagem.edSequencia.Text:='1'
      else
        frPesagem.edSequencia.Text:=IntToStr(sequencia+1);
      edCodParceiro.SetFocus;
    end
  else
    begin
      // A consulta não trouxe nenhum registro
      ShowMessage('Nenhum registro encontrado.');
    end;
end;

procedure TfrPesagem.edPlacaExit(Sender: TObject);
var
  i: Integer;
  Placa: string;
  CaractereValido: Boolean;
begin
  Placa := EdPlaca.Text;
  CaractereValido := True;

  // Verifica se a placa tem exatamente 7 caracteres
  if Length(Placa) <> 7 then
    CaractereValido := False
  else
    begin
      // Verifica se cada caractere é uma letra ou número
      for i := 1 to Length(Placa) do
        begin
          if not (Placa[i] in ['A'..'Z', 'a'..'z', '0'..'9']) then
            begin
              CaractereValido := False;
              Break;
            end;
        end;
    end;

  // Se algum caractere for inválido, exibe mensagem de erro e define o foco de volta para o campo
  if not CaractereValido then
    begin
      ShowMessage('A placa deve ter exatamente 7 caracteres alfanuméricos.');
      EdPlaca.SetFocus;
      edPlaca.Clear;
    end
  else
    buscaSequencia;

end;

procedure TfrPesagem.FormShow(Sender: TObject);
begin
  edPlaca.SetFocus;
  limpar;
end;

procedure TfrPesagem.edCodParceiroExit(Sender: TObject);
var
  i:integer;
  codParceiro:string;
  CaractereValido:boolean;
begin
  codParceiro:=edCodParceiro.Text;
  { verifica se foi digitado somente numeros}
  if codParceiro <>'' then
    begin
      for i := 1 to Length(CodParceiro) do
        begin
          if not (codParceiro[i] in ['0'..'9']) then
            begin
              CaractereValido := False;
              Break;
            end;
        end;
      if not CaractereValido then
        begin
          showmessage('Digite somente numero!');
          edCodParceiro.Clear;
          edCodParceiro.SetFocus;
        end
          else
            buscaParceiro;
    end;

end;

procedure TfrPesagem.edCodProdutoExit(Sender: TObject);
var
  i:integer;
  codProduto:string;
  CaractereValido:boolean;
begin
  codProduto:=edCodProduto.Text;
  { verifica se foi digitado somente numeros}
  if codProduto <>'' then
    begin
      for i := 1 to Length(CodProduto) do
        begin
          if not (codProduto[i] in ['0'..'9']) then
            begin
              CaractereValido := False;
              Break;
            end;
        end;
      if not CaractereValido then
        begin
          showmessage('Digite somente numero!');
          edCodProduto.SetFocus;
          edCodProduto.Clear;
        end
      else
        buscaProduto;
    end;

end;

procedure TfrPesagem.buscaParceiro;
var
  id:integer;
begin
  id := StrToInt(edCodParceiro.Text);
  dmData.zQueryX.Close;
  dmData.zQueryX.SQL.Text:='SELECT * FROM PARCEIROS WHERE id = :id';
  dmData.zQueryX.ParamByName('id').AsInteger := id; // Define o valor do parâmetro ":id"
  dmData.zQueryX.Open;
  edNomeParceiro.Text:= dmData.zQueryX.FieldByName('nome').AsString;
  edEndereco.Text:=dmData.zQueryX.FieldByName('endereco').AsString;
  edMunicipio.Text:=dmData.zQueryX.FieldByName('municipio').AsString;
  edCodProduto.SetFocus;

end;

procedure TfrPesagem.buscaProduto;
var
  id:integer;
begin
  id := StrToInt(edCodProduto.Text);
  dmData.zQueryX.Close;
  dmData.zQueryX.SQL.Text:='SELECT * FROM PRODUTOS WHERE id = :id';
  dmData.zQueryX.ParamByName('id').AsInteger := id; // Define o valor do parâmetro ":id"
  dmData.zQueryX.Open;
  edNomeProduto.Text:= dmData.zQueryX.FieldByName('nome').AsString;
  edCodMotorista.SetFocus;

end;

procedure TfrPesagem.limpar;
begin
  edPlaca.Clear;
  edSequencia.Clear;
  edCodParceiro.Clear;
  edNomeParceiro.Clear;
  edEndereco.Clear;
  edMunicipio.Clear;
  edCodProduto.Clear;
  edNomeProduto.Clear;
  edPesoTara.Clear;
  edPesoBruto.Clear;
  edPesoLiquido.Clear;
  edCodMotorista.Clear;
  edNomeMotorista.Clear;
  edNotaFiscal.Clear;
  edPesoNota.Clear;
  edObs.Clear;
  grdMovimentacao.ItemIndex:=1;
  grdTipoPesagem.ItemIndex:=1;
end;

procedure TfrPesagem.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := CaFree;
  Release;
  frBritagem:= Nil;
end;

end.
