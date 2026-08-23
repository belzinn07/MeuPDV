unit IProduto.Service;

interface

uses
  System.Generics.Collections, Produto.DTO;
type
 IProdutoService = interface
  ['{BAAD7767-DFBB-41D2-B48D-CA1DC800C8DA}']

  procedure Salvar(AProduto: TProdutoDTO);
  procedure Excluir(AId : Integer);
  function ListarProdutos : TObjectList<TProdutoDTO>;
  function BuscarPorId(AId: Integer) : TProdutoDTO;
  function PesquisarProdutos(APesquisa: String): TObjectList<TProdutoDTO>;

 end;

implementation

end.
