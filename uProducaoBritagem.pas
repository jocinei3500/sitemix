unit uProducaoBritagem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, TeEngine, Series, ExtCtrls, TeeProcs,
  Chart, DbChart, ZAbstractTable, ZDataset, DB, ZAbstractRODataset,
  ZAbstractDataset, ZAbstractConnection, ZConnection, Buttons, pngimage,
  RXCtrls, Mask, ToolEdit, RXSlider;

type
  TfrProducaoBritagem = class(TForm)
    ZTable1: TZTable;
    ZQuery1: TZQuery;
    DataSource1: TDataSource;
    Timer1: TTimer;
    DBChart1: TDBChart;
    po: TLineSeries;
    Panel1: TPanel;
    Image1: TImage;
    Label7: TLabel;
    GroupBox1: TGroupBox;
    edData: TDateEdit;
    RxLabel1: TRxLabel;
    BitBtn3: TBitBtn;
    RxSlider1: TRxSlider;
    RxLabel3: TRxLabel;
    RxLabel4: TRxLabel;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    btRealTimeGraph: TBitBtn;
    Label2: TLabel;
    edQuant: TEdit;
    Label3: TLabel;
    btSetQuantReg: TButton;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label7MouseEnter(Sender: TObject);
    procedure Label7MouseLeave(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure RxSlider1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btSetQuantRegClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btRealTimeGraphClick(Sender: TObject);
  private
    FQuantReg:integer;//quantidade de registros que ser�o buscados do bando de dados
    procedure buscaDados;
    { Private declarations }

  public
    { Public declarations }
  end;

var
  frProducaoBritagem: TfrProducaoBritagem;


implementation

uses uData, uBritagem;

{$R *.dfm}

procedure TfrProducaoBritagem.buscaDados;
var
  Series: TLineSeries;
begin
  RxSlider1.MaxValue:=FQuantReg;
  dmData.qProducao.Close;
  dmData.qProducao.SQL.Text:='select * from (select * from producao_britagem order by id desc limit :quant) as tb order by id asc; ';
  //dmData.qProducao.SQL.Text:='select * from producao_britagem ';
  dmData.qProducao.ParamByName('quant').AsInteger:=FQuantReg;
  dmData.qProducao.Open;

  po.XValues.DateTime := True;
  po.DataSource := dmData.qProducao;
  po.XLabelsSource := 'hora';
  po.YValues.ValueSource := 'producao_po';

end;

procedure TfrProducaoBritagem.FormShow(Sender: TObject);
begin
  FQuantReg:=200;
  edData.Text:=FormatDateTime('dd/mm/yyyy',now);
  RxSlider1.Value:=200;
  buscaDados;
end;

procedure TfrProducaoBritagem.SpeedButton1Click(Sender: TObject);
begin
  timer1.Enabled:=false;
  close;
end;

procedure TfrProducaoBritagem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := CaFree;
  Release;
  frProducaoBritagem:=Nil;
end;

procedure TfrProducaoBritagem.Label7MouseEnter(Sender: TObject);
begin
  label7.Transparent:=false;
  label7.Font.Color:=clWhite;
end;

procedure TfrProducaoBritagem.Label7MouseLeave(Sender: TObject);
begin
  label7.Transparent:=true;
  label7.Font.Color:=clBlack;
end;

procedure TfrProducaoBritagem.Label7Click(Sender: TObject);
begin
close;
end;

procedure TfrProducaoBritagem.BitBtn3Click(Sender: TObject);
begin
  buscaDados;
end;

procedure TfrProducaoBritagem.RxSlider1Change(Sender: TObject);
begin
  dbchart1.MaxPointsPerPage:=rxslider1.Value;

end;

procedure TfrProducaoBritagem.Button1Click(Sender: TObject);
begin
dbChart1.NextPage;
end;

procedure TfrProducaoBritagem.Button2Click(Sender: TObject);
begin
  dbChart1.PreviousPage;
end;

procedure TfrProducaoBritagem.btSetQuantRegClick(Sender: TObject);
var
  i:integer;
  CaractereValido:boolean;
begin

  if edQuant.Text <>'' then
    begin
      CaractereValido:=true;
      for i := 1 to Length(edQuant.Text) do
        begin
          if not (edQuant.Text[i] in ['0'..'9']) then
            begin
              CaractereValido := False;
              Break;
            end;
        end;
      if not CaractereValido then
        begin
          showmessage('Digite somente numero!');
          edQuant.Clear;
          edQuant.SetFocus;
        end
      else
        begin
          FQuantReg:=StrToInt(edQuant.Text);
        end
    end;
end;

procedure TfrProducaoBritagem.Timer1Timer(Sender: TObject);
begin
  buscaDados;
end;

procedure TfrProducaoBritagem.btRealTimeGraphClick(Sender: TObject);
begin
    if btRealTimeGraph.Caption='Iniciar' then
    begin
      timer1.Enabled:=true;
      btRealTimeGraph.Caption:='Parar';
    end
  else
    begin
      timer1.Enabled:=false;
      btRealTimeGraph.Caption:='Iniciar';
    end;
end;

end.





