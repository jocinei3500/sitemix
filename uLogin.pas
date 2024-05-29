unit uLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls, Buttons, ExtCtrls;

type
  TfrLogin = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    edUser: TEdit;
    edPassword: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frLogin: TfrLogin;

implementation

uses uConfigTags;

{$R *.dfm}

procedure TfrLogin.BitBtn2Click(Sender: TObject);
begin
  if (edUser.Text='jocinei') and (edPassword.Text='123') then
    begin
      if (frConfigTags = Nil) then
      Application.CreateForm(TfrConfigTags,frConfigTags);
      frConfigTags.Show;
      close;
    end
  else
    showMessage('Usuário ou senha incorreto.');
end;

procedure TfrLogin.FormShow(Sender: TObject);
begin
  //edUser.Clear;
  //edPassword.Clear;
  edUser.SetFocus;
end;

end.
