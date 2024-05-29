unit uProducaoBritagem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, TeEngine, Series, ExtCtrls, TeeProcs,
  Chart, DbChart, ZAbstractTable, ZDataset, DB, ZAbstractRODataset,
  ZAbstractDataset, ZAbstractConnection, ZConnection, Buttons, pngimage;

type
  TfrProducaoBritagem = class(TForm)
    ZTable1: TZTable;
    ZQuery1: TZQuery;
    DataSource1: TDataSource;
    Timer1: TTimer;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    DBChart1: TDBChart;
    po: TLineSeries;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    procedure cadastra_random;
  public
    { Public declarations }
  end;

var
  frProducaoBritagem: TfrProducaoBritagem;


implementation

uses uData;

{$R *.dfm}

procedure TfrProducaoBritagem.Button1Click(Sender: TObject);
var
  Series: TLineSeries;
begin
  dmData.qProducao.Close;
  dmData.qProducao.SQL.Text:='select * from (select * from producao_britagem order by id desc limit 100) as tb order by id asc; ';
  dmData.qProducao.Open;

  // Adicionar e configurar a primeira série (pedrisco)

  po.XValues.DateTime := True;
  po.DataSource := dmData.qProducao;
  po.XLabelsSource := 'data_hora';
  po.YValues.ValueSource := 'producao_po';


end;

procedure TfrProducaoBritagem.cadastra_random;
var data_hora:string;
begin
  {randomize;
   data_hora:=formatDateTime('yyyy-mm-dd hh:nn:ss', now());
  tag_po:=tagpo+random(14);
  tag_pedrisco:=pedrisco+random(10);
  tag_pedra34:=pedra34+random(15);
  tag_pedra2:=pedra2+random(7);
  tag_energia_usina:=energia_usina+random(5);
  tag_energia_britagem:=energia_britagem+5+random(12);
  dmData.qProducao.Close;
  dmData.qProducao.SQL.Text:=('INSERT INTO producao_britagem(ID, PO, PEDRISCO,'+
  ' PEDRA34, PEDRA2, ENERGIA_USINA, ENERGIA_BRITAGEM, DATA_HORA) VALUES(:id, :po,'+
  ':producao_po,:pedrisco, :producao_pedrsico, :pedra34, :producao_pedra34, :pedra2,'+
  ':producao_pedra2, :energia_usina, :energia_britagem, :data_hora)');
  dmData.qProducao.ParamByName('id').AsString:='null';
  dmData.qProducao.ParamByName('po').AsFloat:=po;
  dmData.qProducao.ParamByName('producao_po').AsFloat:=po*3600;
  dmData.qProducao.ParamByName('pedrisco').AsFloat:=pedrisco;
  dmData.qProducao.ParamByName('producao_pedrisco').AsFloat:=pedrisco*3600;
  dmData.qProducao.ParamByName('pedra34').AsFloat:=pedra34;
  dmData.qProducao.ParamByName('producao_pedra34').AsFloat:=pedra34*3600;
  dmData.qProducao.ParamByName('pedra2').AsFloat:=pedra2;
  dmData.qProducao.ParamByName('producao_pedra2').AsFloat:=po;
  dmData.qProducao.ParamByName('energia_usina').AsFloat:=energia_usina;
  dmData.qProducao.ParamByName('energia_britagem').AsFloat:=energia_britagem;
  dmData.qProducao.ParamByName('data_hora').AsString:=data_hora;
  dmData.qProducao.ExecSQL;}

end;

procedure TfrProducaoBritagem.Button2Click(Sender: TObject);
begin
  cadastra_random;
end;

procedure TfrProducaoBritagem.Timer1Timer(Sender: TObject);
var
  Series: TLineSeries;
begin
  dmData.qProducao.Close;
  dmData.qProducao.SQL.Text:='select * from (select * from producao_britagem order by id desc limit 100) as tb order by id asc; ';
  dmData.qProducao.Open;

  // Adicionar e configurar a primeira série (pedrisco)

  po.XValues.DateTime := True;
  po.DataSource := dmData.qProducao;
  po.XLabelsSource := 'hora';
  po.YValues.ValueSource := 'producao_po';

end;

procedure TfrProducaoBritagem.FormShow(Sender: TObject);
begin
timer1.Enabled:=true;
end;

procedure TfrProducaoBritagem.SpeedButton1Click(Sender: TObject);
begin
  dmData.qProducao.Close;
  timer1.Enabled:=false;
  close;
end;

end.





