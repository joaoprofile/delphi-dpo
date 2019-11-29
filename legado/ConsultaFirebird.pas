unit ConsultaFirebird;

interface

uses Classes, SysUtils, Consulta;

type
  TConsultaFirebird = class(TConsulta)
  public
    function getSQL: String; override;
  end;

implementation

{ TConsultaFirebird }

function TConsultaFirebird.getSQL: String;
var
  SQL: TStringList;
begin
  SQL := TStringList.Create;
  try
    SQL.Text := inherited getSQL;
    if getQtdRegistros > 0 then
      SQL[0] := SQL[0] + ' first ' + IntToStr(getQtdRegistros);
    if getSalto > 0 then
      SQL[0] := SQL[0] + ' skip ' + IntToStr(getSalto);
    Result := SQL.Text;
  finally
    SQL.Free;
  end;
end;

end.
