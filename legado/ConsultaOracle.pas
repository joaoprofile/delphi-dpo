unit ConsultaOracle;

interface

uses Classes, SysUtils, Consulta;

type
  TConsultaOracle = class(TConsulta)
  public
    function getSQL: String; override;
  end;

implementation

uses Operacao;

{ TConsultaOracle }

function TConsultaOracle.getSQL: String;
begin
//  if (getQtdRegistros > 0) or (getSalto > 0) then
//    setCampos('rownum as linha,' +
//      StringReplace(getCampos, '*', getTabela + '.*', [rfReplaceAll]));
  if (getQtdRegistros > 0) and (getSalto >= 0) then
  begin
    if Trim(getCondicao) <> EmptyStr then
      setCondicao(getCondicao + ' and ');
    setCondicao(getCondicao + '(rownum between ' +
      intToStr(getSalto) + ' and ' +
      intToStr(getSalto + getQtdRegistros) + ')');
  end
  else if (getSalto > 0) then
  begin
    if Trim(getCondicao) <> EmptyStr then
      setCondicao(getCondicao + ' and ');
    setCondicao(getCondicao + '(rownum >= ' +
      IntToStr(getSalto) +  ')');
    end;    
  Result := inherited getSQL;
end;

end.
