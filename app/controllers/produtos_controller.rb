class ProdutosController < ApplicationController
	before_action :set_produto, only: [:destroy, :edit, :update]

	def index
		@produtos_por_nome = Produto.order(:nome).limit 5
		@produtos_por_preco = Produto.order(:preco).limit 2
	end

	def new
		@produto = Produto.new
		renderiza :new
	end

	def create
		@produto = Produto.new produto_params
		if @produto.save
			#flash[:notice] = "Produto salvo com sucesso!"
			redirect_to root_path, notice: "Produto salvo com sucesso!"
		else
			renderiza :new
		end
	end

	def edit
		renderiza :edit
	end

	def update
		if @produto.update produto_params
			flash[:notice] = "Produto alterado com sucesso"
			redirect_to root_path
		else
			renderiza :edit
		end
	end

	def destroy
		@produto.destroy
		redirect_to root_path
	end

	def busca
		@nome_a_buscar = params[:nome]
		@produtos = Produto.where "nome like ?", "%#{@nome_a_buscar}%"
	end

	private 

	def set_produto
		id = params[:id]
		@produto = Produto.find(id)
	end

	def produto_params
		params.require(:produto).permit :nome, :preco, :descricao, :quantidade, :departamento_id
	end

	def renderiza(view)
		@depatamentos = Departamento.all
		render view
	end

end
