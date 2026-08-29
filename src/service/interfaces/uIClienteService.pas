unit uIClienteService;

interface

uses
  System.Generics.Collections, uClienteDTO;
type
 IClienteService = interface
   ['{AA8CCFD7-7AF4-48C9-BD92-E30FABD9776A}']

   procedure Salvar(const ACliente : TClienteDTO);
   procedure Excluir(AId : Integer);
   function Listar : TObjectList<TClienteDTO>;
   function BuscarPorId(AId : Integer) : TClienteDTO;
   function Pesquisar(const APesquisa : string) : TObjectList<TClienteDTO>;

 end;


implementation

end.
