unit ConsultaPostgreSQL;

interface

uses Classes, SysUtils, Consulta;

type
  TConsultaPostgreSQL = class(TConsulta)
  public
    function getSQL: String; override;
  end;

implementation

{ TConsultaPostgreSQL }

function TConsultaPostgreSQL.getSQL: String;
var
  SQL: TStringList;
begin
  SQL := TStringList.Create;
  try
    SQL.Text := inherited getSQL;
    if getQtdRegistros > 0 then
      SQL.Add('limit ' + IntToStr(getQtdRegistros));
    if getSalto > 0 then
      SQL.Add('offset ' + IntToStr(getSalto));
    Result := SQL.Text;
  finally
    SQL.Free;
  end;
end;

end.
