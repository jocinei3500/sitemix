unit uBritagem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ZAbstractConnection, ZConnection, ZAbstractTable, ZDataset, DB,
  ZAbstractRODataset, ZAbstractDataset, ExtCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdModBusClient, Grids,
  DBGrids, StdCtrls, pngimage, connectionThreadUnit, jpeg, IdIcmpClient, IdException, IdGlobal,
  Buttons;

type
  TfrBritagem = class(TForm)
    tReadPLC: TTimer;
    mctPLC: TIdModBusClient;
    Label16: TLabel;
    M3: TShape;
    Label14: TLabel;
    M11: TShape;
    M12: TShape;
    Label18: TLabel;
    M13: TShape;
    M19: TShape;
    M14: TShape;
    M15: TShape;
    M10: TShape;
    M20: TShape;
    M18: TShape;
    M16: TShape;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    M5: TShape;
    M6: TShape;
    M9: TShape;
    imgPrincipal: TImage;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    M4: TShape;
    M8: TShape;
    M7: TShape;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    M17: TShape;
    Label4: TLabel;
    M2: TShape;
    Label12: TLabel;
    M1: TShape;
    Label13: TLabel;
    Edit4: TEdit;
    Edit9: TEdit;
    Label30: TLabel;
    edProdPo: TPanel;
    tTryConnect: TTimer;
    edProdPoH: TEdit;
    Panel1: TPanel;
    edProdPedra2: TPanel;
    Edit2: TEdit;
    Edit3: TEdit;
    edProdPedra2H: TEdit;
    Panel3: TPanel;
    edProdPedrisco: TPanel;
    edProdPedriscoH: TEdit;
    Panel5: TPanel;
    Edit5: TEdit;
    Edit6: TEdit;
    Panel6: TPanel;
    Edit8: TEdit;
    Panel7: TPanel;
    Edit10: TEdit;
    Edit11: TEdit;
    Panel8: TPanel;
    Edit12: TEdit;
    Panel9: TPanel;
    Edit13: TEdit;
    Edit14: TEdit;
    edProdPedra34: TPanel;
    edProdPedra34H: TEdit;
    Panel11: TPanel;
    Edit16: TEdit;
    Edit17: TEdit;
    BitBtn1: TBitBtn;
    tReconnect: TTimer;
    Timer1: TTimer;
    Label5: TLabel;
    edEnergiaBritagem: TLabel;
    edEnergiaUsina: TLabel;
    procedure FormShow(Sender: TObject);
    procedure tReadPLCTimer(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure edProdPoDblClick(Sender: TObject);
    procedure tTryConnectTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tReconnectTimer(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    procedure saveTagsToBase;
    procedure buscaConfig;
    function readCoil(memory:integer):integer;
    function buscaDigitais(coil:integer):integer;
    procedure Reconnect;
    procedure restaurarDefault;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frBritagem: TfrBritagem;
  tag_po, tag_pedrisco, tag_pedra34, tag_pedra2, tag_energia_usina,tag_energia_britagem:integer;
  modBusHost:string;
  intervalo_clp_britagem:cardinal;//intervalo do timer lê variaveis do clp
  tDigitalPLC:array[1..20] of integer;//entradas digitais dOS MOTORES
  tCoil:array[1..13] of integer;
  bCoil:array[1..4] of integer;
  pCoil:array[1..3]of integer;
  gProducao:array[1..8] of double;
  FCanClose, FConnected:boolean;
  FTryConnect:integer;

implementation

uses uData, uProducaoBritagem;

{$R *.dfm}




procedure Wait(Delay: Integer);
var
  TargetTime: TDateTime;
begin
  TargetTime := Now + Delay / 86400000; // Converte milissegundos em fração de dia
  while Now < TargetTime do
  begin
    Application.ProcessMessages; // Processa mensagens pendentes
    Sleep(10); // Pausa por 10 milissegundos para evitar uso excessivo de CPU
  end;
end;

function Ping(const Host: string): Boolean;
var
  ICMPClient: TIdIcmpClient;
begin
  Result := False;
  ICMPClient := TIdIcmpClient.Create(nil);
  try
    try
      ICMPClient.Host := Host;
      ICMPClient.Ping;
      Result := ICMPClient.ReplyStatus.ReplyStatusType = rsEcho;
    except
      on E: Exception do
        // Tratar exceções, se necessário
    end;
  finally
    ICMPClient.Free;
  end;
end;


procedure TfrBritagem.saveTagsToBase;
  var
    Data: array[0..4096] of Word;
    dPo, dPedrisco,dpedra34, dPedra2, dEnergiaUsina,dEnergiaBritagem:Real;
    producao_po, producao_pedrisco, producao_pedra34, producao_pedra2:Real;
    date, hora:string;
    i:integer;//usado para loço for
    Shape:TShape;
begin
  //zerando as variáveis pra não dar erro.
  dPO:=0; dPedrisco:=0; dPedra34:=0; dPedra2:=0; dEnergiaUsina:=0;dEnergiaBritagem:=0;

  date:=formatDateTime('yyyy-mm-dd', now);
  hora:=formatDateTime('hh:nn:ss',now);
  try
    if mctPLC.ReadHoldingRegisters(tag_po,1, Data)then//leitura do pó
      begin
        dPo:=Data[0]/4;
        edProdPo.Caption:=FloatToStr(Round(dPo))+' ';
      end;
    if mctPLC.ReadHoldingRegisters(tag_pedrisco,10, Data)then//pedrisco
      begin
        dPedrisco:=Data[0]/4;
        edProdPedrisco.Caption:=FloatToStr(dPedrisco);
      end;
    if mctPLC.ReadHoldingRegisters(tag_pedra34,10, Data)then//pedra34
      begin
        dPedra34:=Data[0]/4;
        edProdPedra34.Caption:=FloatToStr(dPedra34);
      end;
    if mctPLC.ReadHoldingRegisters(tag_pedra2,10, Data)then//pedra2
      begin
        dPedra2:=Data[0]/4;
        edProdPedra2.Caption:=FloatToStr(dPedra2);
      end;
    if mctPLC.ReadHoldingRegisters(tag_energia_usina,10, Data)then//energia_usina
      begin
        dEnergiaUsina:=Data[0]/4;
        edEnergiaUsina.Caption:=FloatToStr(dEnergiaUsina);
      end;
    if mctPLC.ReadHoldingRegisters(tag_energia_britagem,1, Data)then//energia britagem
      begin
        dEnergiaBritagem:=Data[0];
        edEnergiaBritagem.Caption:=' '+ FloatToStr(dEnergiaBritagem);
      end;


    //laço for leê as entradas digitais M.
    for i:=1 to 13 do
      begin
        tCoil[i]:=readCoil(tDigitalPLC[i]);
        Shape := FindComponent('M' + IntToStr(i)) as TShape;
        if Shape <> nil then//laço que verifica se as tags da correias estão on ou off.
          if tCoil[i]=1 then
            Shape.Brush.Color:=$0040FF00
          else
            Shape.Brush.Color:=clSilver;
      end;

  except
    restaurarDefault;
    tReadPLC.Enabled:=false;
    tReconnect.Enabled:=true;
    exit;
  end;

  try
    // Inicia busca da pesagem id -10 para fazer a média de produção
    dmData.qCadProdLocal.Close;
    dmData.qCadProdLocal.SQL.Text:='SELECT * FROM producao_britagem WHERE id='+
    '(SELECT MAX(id) FROM producao_britagem)-9';
    dmData.qCadProdLocal.Open;
  except
    ShowMessage('Erro ao tentar acessar o banco de dados.');
  end;
    producao_po:= dmData.qCadProdLocal.FieldByName('po').AsFloat;
    producao_pedrisco:= dmData.qCadProdLocal.FieldByName('pedrisco').AsFloat;
    producao_pedra34:= dmData.qCadProdLocal.FieldByName('pedra34').AsFloat;
    producao_pedra2:= dmData.qCadProdLocal.FieldByName('pedra2').AsFloat;


    producao_po:=(dpo-producao_po)/10*3600;
    if producao_po <0 then producao_po:=0;
    edProdPoH.Text:=' '+ FloatToStr(producao_po)+'';
    producao_pedrisco:=(dpedrisco-producao_pedrisco)/10*3600;
    if producao_pedrisco <0 then producao_pedrisco:=0;
    producao_pedra34:=(dpedra34-producao_pedra34)/10*3600;
    if producao_pedra34 <0 then producao_pedra34:=0;
    producao_pedra2:=(dpedra2-producao_pedra2)/10*3600;
    if producao_pedra2 <0 then producao_pedra2:=0;
    try
      try
        // Inicia cadastro local dos dados.
        dmData.qCadProdLocal.close;
        dmData.qCadProdLocal.SQL.Text:='';
        dmData.qCadProdLocal.SQL.Text:=('INSERT INTO producao_britagem (id, po, producao_po, '+
        'pedrisco,producao_pedrisco, pedra34, producao_pedra34, pedra2, producao_pedra2,'+
        ' energia_usina, energia_britagem, data, hora)'+
        ' VALUES(:id, :po, :producao_po, :pedrisco, :producao_pedrisco, :pedra34,'+
        ' :producao_pedra34, :pedra2, :producao_pedra2, :energia_usina, :energia_britagem, :data, :hora)');
        dmData.qCadProdLocal.ParamByName('id').AsString:='null';
        dmData.qCadProdLocal.ParamByName('po').AsFloat:=dPo;
        dmData.qCadProdLocal.ParamByName('producao_po').AsFloat:=producao_po;
        dmData.qCadProdLocal.ParamByName('pedrisco').AsFloat:=dPedrisco;
        dmData.qCadProdLocal.ParamByName('producao_pedrisco').AsFloat:=producao_pedrisco;
        dmData.qCadProdLocal.ParamByName('pedra34').AsFloat:=dpedra34;
        dmData.qCadProdLocal.ParamByName('producao_pedra34').AsFloat:=producao_pedra34;
        dmData.qCadProdLocal.ParamByName('pedra2').AsFloat:=dpedra2;
        dmData.qCadProdLocal.ParamByName('producao_pedra2').AsFloat:=producao_pedra2;
        dmData.qCadProdLocal.ParamByName('energia_usina').AsFloat:=dEnergiaUsina;
        dmData.qCadProdLocal.ParamByName('energia_britagem').AsFloat:=dEnergiaBritagem;
        dmData.qCadProdLocal.ParamByName('data').AsString:=date;
        dmData.qCadProdLocal.ParamByName('hora').AsString:=hora;
        dmData.qCadProdLocal.ExecSQL;
        dmData.zConnLocal.Commit;
        dmData.qCadProdLocal.Close;
      except
        showmessage('Não foi  gravar no abnco de dados'+#13+
        'verifique a conexão com o banco de dados local!');
      end;
      try
        //Inicia o cadastro no banco remoto.
        dmData.qCadProdRemote.close;
        dmData.qCadProdRemote.SQL.Text:='';
        dmData.qCadProdRemote.SQL.Text:=('INSERT INTO producao_britagem (id, po, producao_po, '+
        'pedrisco,producao_pedrisco, pedra34, producao_pedra34, pedra2, producao_pedra2,'+
        ' energia_usina, energia_britagem, data, hora)'+
        ' VALUES(:id, :po, :producao_po, :pedrisco, :producao_pedrisco, :pedra34,'+
        ' :producao_pedra34, :pedra2, :producao_pedra2, :energia_usina, :energia_britagem, :data, :hora)');
        dmData.qCadProdRemote.ParamByName('id').AsString:='null';
        dmData.qCadProdRemote.ParamByName('po').AsFloat:=dPo;
        dmData.qCadProdRemote.ParamByName('producao_po').AsFloat:=producao_po;
        dmData.qCadProdRemote.ParamByName('pedrisco').AsFloat:=dPedrisco;
        dmData.qCadProdRemote.ParamByName('producao_pedrisco').AsFloat:=producao_pedrisco;
        dmData.qCadProdRemote.ParamByName('pedra34').AsFloat:=dpedra34;
        dmData.qCadProdRemote.ParamByName('producao_pedra34').AsFloat:=producao_pedra34;
        dmData.qCadProdRemote.ParamByName('pedra2').AsFloat:=dpedra2;
        dmData.qCadProdRemote.ParamByName('producao_pedra2').AsFloat:=producao_pedra2;
        dmData.qCadProdRemote.ParamByName('energia_usina').AsFloat:=dEnergiaUsina;
        dmData.qCadProdRemote.ParamByName('energia_britagem').AsFloat:=dEnergiaBritagem;
        dmData.qCadProdRemote.ParamByName('data').AsString:=date;
        dmData.qCadProdRemote.ParamByName('hora').AsString:=hora;
        dmData.qCadProdRemote.ExecSQL;
        dmData.zConnRemote.Commit;
        dmData.qCadProdRemote.Close
      except
      end;
    except
        tReadPLC.Enabled:=false;
        tReconnect.Enabled:=true;
    end;


end;

procedure TfrBritagem.FormShow(Sender: TObject);
begin
  restaurarDefault;
  buscaConfig;
  tReadPLC.Interval:=intervalo_clp_britagem;//pega a configuração salva no banco de dados
  mctPLC.Host := modBusHost;
  tTryConnect.Enabled:=true;
  cursor:=crHourGlass;
end;



procedure TfrBritagem.tReadPLCTimer(Sender: TObject);
begin
  saveTagsToBase;
end;





procedure TfrBritagem.buscaConfig;
var
  i:integer;
begin
  dmData.zQueryX.Close;
  dmData.zQueryX.SQL.Text:='SELECT * FROM config_tags where nome = :nome';
  dmData.zQueryX.ParamByName('nome').AsString := 'po'; // Define o valor do parâmetro ":id"
  dmData.zQueryX.Open;
  tag_po:= dmData.zQueryX.FieldByName('valor').AsInteger;

  dmData.zQueryX.Close;
  dmData.zQueryX.SQL.Text:='SELECT * FROM config_tags where nome = :nome';
  dmData.zQueryX.ParamByName('nome').AsString := 'pedrisco'; // Define o valor do parâmetro ":id"
  dmData.zQueryX.Open;
  tag_pedrisco:= dmData.zQueryX.FieldByName('valor').AsInteger;

  dmData.zQueryX.Close;
  dmData.zQueryX.SQL.Text:='SELECT * FROM config_tags where nome = :nome';
  dmData.zQueryX.ParamByName('nome').AsString := 'pedra34'; // Define o valor do parâmetro ":id"
  dmData.zQueryX.Open;
  tag_pedra34:= dmData.zQueryX.FieldByName('valor').AsInteger;

  dmData.zQueryX.Close;
  dmData.zQueryX.SQL.Text:='SELECT * FROM config_tags where nome = :nome';
  dmData.zQueryX.ParamByName('nome').AsString := 'pedra2'; // Define o valor do parâmetro ":id"
  dmData.zQueryX.Open;
  tag_pedra2:= dmData.zQueryX.FieldByName('valor').AsInteger;

  dmData.zQueryX.Close;
  dmData.zQueryX.SQL.Text:='SELECT * FROM config_tags where nome = :nome';
  dmData.zQueryX.ParamByName('nome').AsString := 'energia_usina'; // Define o valor do parâmetro ":id"
  dmData.zQueryX.Open;
  tag_energia_usina:= dmData.zQueryX.FieldByName('valor').AsInteger;
  dmData.zQueryX.Close;

  dmData.zQueryX.SQL.Text:='SELECT * FROM config_tags where nome = :nome';
  dmData.zQueryX.ParamByName('nome').AsString := 'energia_britagem'; // Define o valor do parâmetro ":id"
  dmData.zQueryX.Open;
  tag_energia_britagem:= dmData.zQueryX.FieldByName('valor').AsInteger;
  dmData.zQueryX.Close;

  dmData.zQueryX.SQL.Text:='SELECT * FROM config_tags where nome = :nome';
  dmData.zQueryX.ParamByName('nome').AsString := 'host_britagem'; // Define o valor do parâmetro ":id"
  dmData.zQueryX.Open;
  modBusHost:= dmData.zQueryX.FieldByName('valor').AsString;
  dmData.zQueryX.Close;

  dmData.zQueryX.SQL.Text:='SELECT * FROM config_tags where nome = :nome';
  dmData.zQueryX.ParamByName('nome').AsString := 'intervalo_busca_clp'; // Define o valor do parâmetro ":id"
  dmData.zQueryX.Open;
  intervalo_clp_britagem:= dmData.zQueryX.FieldByName('valor').AsInteger;
  dmData.zQueryX.Close;
  i:=1;
  for i:=1 to 20 do
    begin
      dmData.zQueryX.SQL.Text:='SELECT * FROM config_tags where nome = :nome';
      dmData.zQueryX.ParamByName('nome').AsString :='M'+ IntToStr(i);
      dmData.zQueryX.Open;
      tDigitalPlc[i]:= dmData.zQueryX.FieldByName('valor').AsInteger;
      dmData.zQueryX.Close;
    end;
end;


function TfrBritagem.readCoil(memory: integer): integer;
  var
    Coils: array of Boolean;
    StartAddress: Word;
    Quantity: Word;
begin
  StartAddress := memory; // Endereço inicial do coil
  Quantity := 1; // Quantidade de coils a serem lidos (pode ser mais de um)

  // Ajustar o tamanho do array de coils
  SetLength(Coils, Quantity);

  try
    // Conectando ao CLP
    mctPLC.Connect;
    try
      // Lendo os coils
      mctPLC.ReadCoils(StartAddress, Quantity, Coils);

      // Verificando o status do coil
      if Coils[0] then
        result:=1
      else
        result:=0;
    finally
      mctPLC.Disconnect;
    end;
  except
    on E: Exception do
      ShowMessage('Error reading coil: ' + E.Message);
  end;
end;

function TfrBritagem.buscaDigitais(coil:integer):integer;
var
  Coils: array of Boolean;
  StartAddress: Word;
  Quantity: Word;
begin
  StartAddress := coil+2049; // Endereço inicial do coil
  Quantity := 1; // Quantidade de coils a serem lidos (pode ser mais de um)
  // Ajustar o tamanho do array de coils
  SetLength(Coils, Quantity);
    try
      // Lendo os coi'ls
      if mctPLC.ReadCoils(StartAddress, Quantity, Coils)then
        begin
        // Verificando o status do coil
          if Coils[0] then
            result:=1
          else
            result:=0;
        end;
    except
      showmessage('Erro ao tentar ler memória do CLP')
    end;
end;

procedure TfrBritagem.BitBtn2Click(Sender: TObject);
begin
  frProducaoBritagem.showModal;
end;

procedure TfrBritagem.edProdPoDblClick(Sender: TObject);
begin
  frProducaoBritagem.showModal;
end;

procedure TfrBritagem.tTryConnectTimer(Sender: TObject);
begin
  tTryConnect.Enabled:=false;

  if not Ping(ModBusHost) then//verifica se é possivel conectar ao CLP.
    begin
      showmessage('Não foi possível criar uma conexão com o IP '+modBusHost +
      #13 +'1. Verifique a conexão com sua rede.'+#13+
      '2. verifique se o endereço de IP está correto.');
      cursor:=crDefault;
      exit;
    end;
  cursor:=crDefault;
  if dmData.RemoteDataBaseConnect= false then
    exit;
  if dmData.LocalDataBaseConnect= false then
    exit;

  tReadPLC.Enabled:=true;
end;

procedure TfrBritagem.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TReadPLC.Enabled:=false;
  dmData.zConnRemote.Disconnect;
end;

procedure TfrBritagem.tReconnectTimer(Sender: TObject);
begin
  reconnect;
end;

procedure TfrBritagem.BitBtn1Click(Sender: TObject);
begin
  //timer1.Enabled:=true;
  saveTagsToBase;
  //reconnect;
end;

procedure TfrBritagem.Reconnect;
begin
  cursor:=crHourGlass;
  if not Ping(ModBusHost) then//verifica se é possivel conectar ao CLP.
    begin
      cursor:=crDefault;
      exit;
    end;
  cursor:=crDefault;
  if dmData.RemoteDataBaseConnect= false then
    exit;
  if dmData.LocalDataBaseConnect= false then
    exit;
  tReadPLC.Enabled:=true;
  tReconnect.Enabled:=false;
end;

procedure TfrBritagem.restaurarDefault;
var
  M:TShape;
  i:integer;

begin
  //restaurta todos os shapes dos motores para desligado
  for i:=1 to 13 do
      begin
        M := FindComponent('M' + IntToStr(i)) as TShape;
        if M <> nil then//coloca todas as shapes com off
            M.Brush.Color:=clSilver;
      end;
  edProdpo.Caption:='';
  edEnergiaBritagem.Caption:='';
  edEnergiaUsina.Caption:='';

end;

end.
