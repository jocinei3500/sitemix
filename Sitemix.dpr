program Sitemix;

uses
  Forms,
  uMain in 'uMain.pas' {frMain},
  uBritagem in 'uBritagem.pas' {frBritagem},
  ufrPesagem in 'ufrPesagem.pas' {frPesagem},
  uCadProduto in 'uCadProduto.pas' {frCadProduto},
  uCadParceiro in 'uCadParceiro.pas' {frCadParceiro},
  ConnectionThreadUnit in 'ConnectionThreadUnit.pas',
  uBuscaParceiro in 'uBuscaParceiro.pas' {frBuscaParceiro},
  uBuscaProduto in 'uBuscaProduto.pas' {frBuscaProduto},
  uGetPeso in 'uGetPeso.pas' {frGetPeso},
  uData in 'uData.pas' {dmData: TDataModule},
  uConfigTags in 'uConfigTags.pas' {frConfigTags},
  ufrBritagem2 in 'ufrBritagem2.pas' {frBritagem2},
  uLogin in 'uLogin.pas' {frLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrMain, frMain);
  Application.CreateForm(TfrBritagem, frBritagem);
  Application.CreateForm(TfrPesagem, frPesagem);
  Application.CreateForm(TfrCadProduto, frCadProduto);
  Application.CreateForm(TfrCadParceiro, frCadParceiro);
  Application.CreateForm(TfrBuscaParceiro, frBuscaParceiro);
  Application.CreateForm(TfrBuscaProduto, frBuscaProduto);
  Application.CreateForm(TfrGetPeso, frGetPeso);
  Application.CreateForm(TdmData, dmData);
  Application.CreateForm(TfrConfigTags, frConfigTags);
  Application.CreateForm(TfrBritagem2, frBritagem2);
  Application.CreateForm(TfrLogin, frLogin);
  Application.Run;
end.
