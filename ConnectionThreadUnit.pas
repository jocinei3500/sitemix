unit ConnectionThreadUnit;

interface

uses
  Classes, IdModBusClient, SysUtils;

type
  TConnectionThread = class(TThread)
  private
    FIpAddress: string;
    FModbusClient: TIdModBusClient;
    FSuccess: Boolean;
  protected
    procedure Execute; override;
  public
    constructor Create(const IpAddress: string);
    property Success: Boolean read FSuccess;
  end;

implementation

constructor TConnectionThread.Create(const IpAddress: string);
begin
  inherited Create(True); // Cria a thread suspensa
  FIpAddress := IpAddress;
  FreeOnTerminate := True;
end;

procedure TConnectionThread.Execute;
begin
  FModbusClient := TIdModBusClient.Create(nil);
  try
    FModbusClient.Host := FIpAddress;
    try
      FModbusClient.Connect;
      FSuccess := FModbusClient.Connected;
    except
      FSuccess := False;
    end;
  finally
    FModbusClient.Free;
  end;
end;

end.

