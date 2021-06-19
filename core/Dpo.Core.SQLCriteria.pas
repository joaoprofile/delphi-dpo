unit Dpo.Core.SQLCriteria;

interface

uses
  SysUtils, Generics.Collections, System.JSON, Dpo.Core.Interfaces;

type
  TCriteriaFilter = class(TInterfacedObject, ICriteriaFilter)
  private
    FExpression: String;
    FPropName: String;
    FValue: String;
  public
    constructor Create;

    Property Expression: String read FExpression write FExpression;
    Property PropName: String read FPropName write FPropName;
    Property Value: String read FValue write FValue;
  end;

  TFilter = class(TInterfacedObject, IFilter)
  private
    FCriteria: TObjectList<TCriteriaFilter>;
  public
    constructor Create;
    destructor Destroy; override;

    function Add(AValue: ICriteriaFilter): IFilter;
    function Criteria: TObjectList<ICriteriaFilter>;
  end;

  TExp = class
  public
    class function &Equal(APropName: string; AValue: Variant): TCriteriaFilter;
    class function &Like(APropName: string; AValue: Variant): TCriteriaFilter;
    class function &And(APropName, APropName2: string; AValue, AValue2: Variant): TCriteriaFilter;
    class function &Or(APropName, APropName2: string; AValue, AValue2: Variant): TCriteriaFilter;
    class function &GreaterOrEqual(APropName, APropName2: string; AValue, AValue2: Variant): TCriteriaFilter;
    class function &LessOrEqual(APropName, APropName2: string; AValue, AValue2: Variant): TCriteriaFilter;
    class function &OrderBy(APropName: string): TCriteriaFilter;
  end;

implementation


{ TExp }

class function TExp.&Equal(APropName: string; AValue: Variant
      ): TCriteriaFilter;
begin
  Result := TCriteriaFilter.Create;
  Result.Expression := '=';
  Result.PropName := APropName;
  Result.Value := AValue;
end;

class function TExp.&Like(APropName, APropName2: string; AValue,
  AValue2: Variant): TCriteriaFilter;
begin
  Result := TCriteriaFilter.Create;
  Result.Expression := 'LIKE';
  Result.PropName := APropName;
  Result.Value := AValue;
end;

class function TExp.&And(APropName, APropName2: string; AValue,
  AValue2: Variant): TCriteriaFilter;
begin
  Result := TCriteriaFilter.Create;
  Result.Expression := 'AND';
  Result.PropName := APropName;
  Result.Value := AValue;
end;

class function TExp.OrderBy(APropName: string): TCriteriaFilter;
begin
  Result := TCriteriaFilter.Create;
  Result.Expression := 'ORDERASC';
  Result.PropName := APropName;
  Result.Value := '';
end;

{ TFilter }

constructor TFilter.Create;
begin
  inherited;
  FCriteria := TObjectList<TCriteriaFilter>.Create;
end;

function TFilter.Add(AValue: TCriteriaFilter): IFilter;
begin
  result := self;
  FCriteria.Add(AValue);
end;

function TFilter.Criteria: TObjectList<ICriteriaFilter>;
begin
  Result := FCriteria;
end;

destructor TFilter.Destroy;
begin
  FCriteria.Free;
  inherited;
end;

{ TCriteriaFilter }

constructor TCriteriaFilter.Create;
begin
  FExpression := '';
  FPropName := '';
  FValue := '';
end;

end.
