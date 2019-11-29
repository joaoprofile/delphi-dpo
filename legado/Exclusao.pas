unit Exclusao;

interface

uses Classes, SysUtils, ConfigBD, Operacao;

type
  TExclusao = class(TOperacao)
  public
    class function getExclusao(tipoBanco: TTipoBanco): TExclusao;
    function getSQL: string; override;
  end;

implementation

{ TExclusao }

class function TExclusao.getExclusao(tipoBanco: TTipoBanco): TExclusao;
begin
  Result := TExclusao.Create;
end;

function TExclusao.getSQL: string;
var
  SQL: TStringList;
begin
  SQL := TStringList.Create;
  try
    with SQL do
    begin
      Add('delete from');
      Add(ident + getTabela);
      if Trim(getCondicao) <> EmptyStr then
      begin
        Add('where');
        Add(ident + getCondicao);
      end;
    end;
    Result := SQL.Text;
  finally
    SQL.Free;
  end;
end;

end.
