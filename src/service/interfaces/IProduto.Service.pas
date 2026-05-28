unit IProduto.Service;

interface

uses
  Produto.Model,
  System.Generics.Collections;
type
 IProdutoService = interface
  ['{BAAD7767-DFBB-41D2-B48D-CA1DC800C8DA}']

  procedure Salvar(AProduto: TProduto);
  procedure Excluir(AId : Integer);
  function ListarProdutos : TObjectList<TProduto>;
  function BuscarPorId(AId: Integer) : TProduto;
  function PesquisarProdutos(APesquisa: String): TObjectList<TProduto>;

 end;

implementation

end.
