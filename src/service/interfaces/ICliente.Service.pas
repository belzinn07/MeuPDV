unit ICliente.Service;

interface

uses
  Cliente.Model, System.Generics.Collections;
type
 IClienteService = interface
   ['{AA8CCFD7-7AF4-48C9-BD92-E30FABD9776A}']

   procedure Salvar(const ACliente : TCliente);
   procedure Excluir(AId : Integer);
   function Listar : TObjectList<TCliente>;
   function BuscarPorId(AId : Integer) : TCliente;
   function Pesquisar(const APesquisa : string) : TObjectList<TCliente>;

 end;


implementation

end.
