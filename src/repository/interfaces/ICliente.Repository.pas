unit ICliente.Repository;

interface

uses
  Cliente.Model, System.Generics.Collections;
type
 IClienteRepository = interface
   ['{1FBADF88-1FA8-48B4-AFE6-72BF0ACF1B5D}']

   procedure Inserir(const ACliente : TCliente);
   procedure Atualizar(const ACliente: TCliente);
   procedure Excluir(AId: Integer);
   function Listar: TObjectList<TCliente>;
   function BuscarPorId(d : Integer): TCliente;
   function Pesquisar(const APesquisa : string): TObjectList<TCliente>;

 end;

implementation

end.
