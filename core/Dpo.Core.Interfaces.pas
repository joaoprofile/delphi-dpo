unit Dpo.Core.Interfaces;

interface

uses
  System.Generics.Collections;

type
  TDriverName = (SQLite, Firebird, MySQL, Postgres, MSSQL, Oracle);

  IEntityMetadata = interface
    ['{1382A3F5-A604-4576-AB2F-BC1565EBF95B}']
    function Fields: String; overload;
    function Fields(Value: String): IEntityMetadata; overload;
    function Table: String; overload;
    function Table(Value: String): IEntityMetadata; overload;
    function PK: String; overload;
    function PK(Value: String): IEntityMetadata; overload;
    function Where: String; overload;
    function Where(Value: String): IEntityMetadata; overload;
    function Values: String; overload;
    function Values(Value: String): IEntityMetadata; overload;
  end;

  IInsert = interface
    ['{F529F2C9-3B85-4AD6-BA4C-8C6E3B598F58}']
    function Metadata: IEntityMetadata;
    function SQL: string;
  end;

  IUpdate = interface
    ['{6B780CCC-E0B3-48D6-978B-7DCA3F6652F9}']
    function Metadata: IEntityMetadata;
    function SQL: string;
  end;

  IRemove = interface
    ['{648161EF-8EAA-4307-A40E-2AA87E1C69F6}']
    function Metadata: IEntityMetadata;
    function SQL: string;
  end;

  IFind = interface
    ['{D599D4D9-B50A-4910-A40D-B98CFC13471F}']
    function Metadata: IEntityMetadata;
    function SQL: string;
  end;

  ICreateTable = interface
    ['{508B4A8F-F2FA-430B-B497-F4B54A4A5845}']
    function Metadata: IEntityMetadata;
    function SQL: string;
  end;

  IDropTable = interface
    ['{2C59E35C-44B3-4FD0-A5C1-11E1175CA676}']
    function Metadata: IEntityMetadata;
    function SQL: string;
  end;

  IEntitySQL = interface
    ['{CCE4A869-1705-48FD-BB62-B2E79168F7D1}']
    function Insert: IInsert;
    function Update: IUpdate;
    function Remove: IRemove;
    function Find: IFind;
    function CreateTable: ICreateTable;
    function DropTable: IDropTable;
  end;

  IQueryRunner = interface
    ['{C033F9C2-A30B-4484-8CF6-F0057A93741D}']
    function CreateTable: IQueryRunner;
    function DropTable: IQueryRunner;

    function Table: string; overload;
    function Table(value: string): IQueryRunner; overload;

    function DDL(value: string): IQueryRunner; overload;
    function DDL: String; overload;

    function Execute: Boolean;
  end;

  IMigration = interface
    ['{C033F9C2-A30B-4484-8CF6-F0057A93741D}']
    function Up(queryRunner: IQueryRunner): IMigration;
    function Down(queryRunner: IQueryRunner): IMigration;
  end;

  ICriteriaFilter = interface
    ['{4C6B8DA5-802E-46AF-82DB-04FA19199144}']
    function Expression: ICriteriaFilter; overload;
    function PropName: ICriteriaFilter; overload;
    function Value: ICriteriaFilter; overload;

    function Expression(value: string): String; overload;
    function PropName(value: string): String; overload;
    function Value(value: string): String; overload;
  end;

  IFilter = interface
    ['{19BA1185-2BAA-4938-A720-C6A5555424BE}']
    function Add(AValue: ICriteriaFilter): IFilter;
  end;


implementation

end.
