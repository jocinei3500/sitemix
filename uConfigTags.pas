unit uConfigTags;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids;

type
  TfrConfigTags = class(TForm)
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edTag1: TEdit;
    btnRead: TButton;
    edTag2: TEdit;
    edTag3: TEdit;
    edTag4: TEdit;
    edTag5: TEdit;
    edtIPAddress: TEdit;
    GroupBox2: TGroupBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    SpeedButton1: TSpeedButton;
    GroupBox3: TGroupBox;
    DBGrid1: TDBGrid;
  private
    { Private declarations }
    procedure save;
  public
    { Public declarations }
  end;

var
  frConfigTags: TfrConfigTags;

implementation

{$R *.dfm}

procedure TfrConfigTags.save;
begin

end;

end.
