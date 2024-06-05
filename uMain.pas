unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ImgList, Menus, ComCtrls, ToolWin, StdCtrls, jpeg,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdModBusClient;

type
  TfrMain = class(TForm)
    Label2: TLabel;
    Image2: TImage;
    ToolBar1: TToolBar;
    btCadastro: TToolButton;
    ToolButton7: TToolButton;
    ToolButton2: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton4: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton6: TToolButton;
    ToolButton12: TToolButton;
    ToolButton1: TToolButton;
    ppCadastro: TPopupMenu;
    OrdemdeServio1: TMenuItem;
    Compras1: TMenuItem;
    Empresas1: TMenuItem;
    CadastrodeEmpresas1: TMenuItem;
    RamodeAtuao1: TMenuItem;
    Setor1: TMenuItem;
    Equipamentos: TMenuItem;
    Primrios1: TMenuItem;
    Secundrios1: TMenuItem;
    Fornecedores1: TMenuItem;
    Servios1: TMenuItem;
    ppAnalise: TPopupMenu;
    Oramentos1: TMenuItem;
    Vendas1: TMenuItem;
    Propostas1: TMenuItem;
    Dvidas1: TMenuItem;
    Desenhos1: TMenuItem;
    Britagem1: TMenuItem;
    ppRelatorio: TPopupMenu;
    Empresas2: TMenuItem;
    ServiosRealizados1: TMenuItem;
    Funcionrios1: TMenuItem;
    ppConsulta: TPopupMenu;
    ConsultaPersonalise1: TMenuItem;
    Empresas3: TMenuItem;
    ServiosRealizados2: TMenuItem;
    ppAjuda: TPopupMenu;
    SobreoSistema1: TMenuItem;
    utorialdoSistema1: TMenuItem;
    ConhecendooSistema1: TMenuItem;
    ImageList1: TImageList;
    ImageList2: TImageList;
    ToolButton13: TToolButton;
    ppBalanca: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    ppSettings: TPopupMenu;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    Produto1: TMenuItem;
    Parceiro1: TMenuItem;
    ToolButton14: TToolButton;
    ToolButton3: TToolButton;
    ToolButton5: TToolButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Britagem1Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure Produto1Click(Sender: TObject);
    procedure Parceiro1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frMain: TfrMain;

implementation

uses uBritagem, ufrPesagem, uConfigTags, uCadProduto, uCadParceiro,
  ufrBritagem2, uLogin, uData;

{$R *.dfm}

procedure TfrMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (ssCtrl in Shift) and (chr(Key) in ['C', 'c']) then
  ppCadastro.Popup(1,130)
else if (ssCtrl in Shift) and (chr(Key) in ['A', 'a']) then
  ppAnalise.Popup(90,130)
else if (ssCtrl in Shift) and (chr(Key) in ['R', 'r']) then
  ppRelatorio.Popup(185,130)
else if (ssCtrl in Shift) and (chr(Key) in ['S', 's']) then
  ppConsulta.Popup(280,130)
else if (ssCtrl in Shift) and (chr(Key) in ['J', 'j']) then
  ppAjuda.Popup(470,130)
end;

procedure TfrMain.Britagem1Click(Sender: TObject);
begin
  if (frBritagem = Nil) then
    Application.CreateForm(TfrBritagem,frBritagem);
    frBritagem.Show;
end;

procedure TfrMain.MenuItem4Click(Sender: TObject);
begin

    if (frLogin= Nil) then
    Application.CreateForm(TfrLogin,frLogin);
    frLogin.ShowModal;
end;

procedure TfrMain.MenuItem1Click(Sender: TObject);
begin

  if (frPesagem = Nil) then
    Application.CreateForm(TfrPesagem,frPesagem);
    frPesagem.Show;
end;

procedure TfrMain.Produto1Click(Sender: TObject);
begin
frCadProduto.showMOdal;
end;

procedure TfrMain.Parceiro1Click(Sender: TObject);
begin
frCadParceiro.showModal;
end;

procedure TfrMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  canclose:=false;
  if messagebox(handle,'Deseja mesmo finalizar o sistema?','Finalizar',mb_Iconquestion+mb_YESNO)=idYes then
    begin
      application.Terminate;
    end
  else
    exit;
end;

end.
