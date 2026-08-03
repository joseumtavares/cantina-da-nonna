-- Criado por Jose Tavares para o perfil Supabase/PostgreSQL.
-- Estes registros iniciais acompanham o cardápio que já existe no front-end.

-- ==========================================================
-- DADOS INICIAIS - CANTINA DA NONNA / SUPABASE
-- ON CONFLICT evita duplicidade quando a aplicação é reiniciada durante os estudos.
-- ==========================================================

-- Categorias principais que organizam o cardápio.
INSERT INTO public.categorias (nome, slug, descricao, ordem_exibicao) VALUES
('Entradas', 'entradas', 'Entradas artesanais para iniciar a refeicao.', 1),
('Massas', 'massas', 'Massas frescas e molhos da casa.', 2),
('Pizzas', 'pizzas', 'Pizzas preparadas no estilo da cantina.', 3),
('Sobremesas', 'sobremesas', 'Doces inspirados na confeitaria italiana.', 4),
('Bebidas', 'bebidas', 'Bebidas para acompanhar o cardapio.', 5)
ON CONFLICT (slug) DO NOTHING^^^

-- Produtos iniciais da categoria Entradas.
INSERT INTO public.produtos (categoria_id, codigo, nome, descricao, valor, imagem, ativo, destaque, ordem_exibicao) VALUES
((SELECT id FROM public.categorias WHERE slug = 'entradas'), 'ENT-001', 'Bruschetta da Nonna', 'Pao italiano com tomate, manjericao e azeite', 22.00, '/images/entradas/bruschetta-da-nonna.png', TRUE, TRUE, 1),
((SELECT id FROM public.categorias WHERE slug = 'entradas'), 'ENT-002', 'Salada Caprese', 'Tomate, mussarela de bufala, manjericao e molho pesto', 28.00, '/images/entradas/salada-caprese.png', TRUE, FALSE, 2),
((SELECT id FROM public.categorias WHERE slug = 'entradas'), 'ENT-003', 'Pao de Alho Artesanal', 'Pao assado com creme de alho e queijo gratinado', 18.00, '/images/entradas/pao-de-alho-artesanal.png', TRUE, FALSE, 3)
ON CONFLICT (codigo) DO NOTHING^^^

-- Produtos iniciais da categoria Massas.
INSERT INTO public.produtos (categoria_id, codigo, nome, descricao, valor, imagem, ativo, destaque, ordem_exibicao) VALUES
((SELECT id FROM public.categorias WHERE slug = 'massas'), 'MAS-001', 'Espaguete a Bolonhesa', 'Massa fresca com molho de tomate e carne moida', 39.00, '/images/massas/espaguete-a-bolonhesa.png', TRUE, FALSE, 1),
((SELECT id FROM public.categorias WHERE slug = 'massas'), 'MAS-002', 'Fettuccine Alfredo', 'Massa fresca com molho branco cremoso e parmesao', 42.00, '/images/massas/fettuccine-alfredo.png', TRUE, TRUE, 2),
((SELECT id FROM public.categorias WHERE slug = 'massas'), 'MAS-003', 'Lasanha da Casa', 'Lasanha artesanal com molho bolonhesa, presunto e queijo', 45.00, '/images/massas/lasanha-da-casa.png', TRUE, FALSE, 3),
((SELECT id FROM public.categorias WHERE slug = 'massas'), 'MAS-004', 'Nhoque ao Sugo', 'Nhoque de batata com molho de tomate caseiro', 38.00, '/images/massas/nhoque-ao-sugo.png', TRUE, FALSE, 4)
ON CONFLICT (codigo) DO NOTHING^^^

-- Produtos iniciais da categoria Pizzas.
INSERT INTO public.produtos (categoria_id, codigo, nome, descricao, valor, imagem, ativo, destaque, ordem_exibicao) VALUES
((SELECT id FROM public.categorias WHERE slug = 'pizzas'), 'PIZ-001', 'Margherita', 'Molho de tomate, mussarela, tomate e manjericao', 52.00, '/images/pizzas/margherita.png', TRUE, TRUE, 1),
((SELECT id FROM public.categorias WHERE slug = 'pizzas'), 'PIZ-002', 'Calabresa', 'Molho de tomate, mussarela, calabresa e cebola', 55.00, '/images/pizzas/calabresa.png', TRUE, FALSE, 2),
((SELECT id FROM public.categorias WHERE slug = 'pizzas'), 'PIZ-003', 'Quatro Queijos', 'Mussarela, provolone, parmesao e gorgonzola', 59.00, '/images/pizzas/quatro-queijos.png', TRUE, FALSE, 3),
((SELECT id FROM public.categorias WHERE slug = 'pizzas'), 'PIZ-004', 'Portuguesa', 'Mussarela, presunto, ovo, cebola, ervilha e azeitona', 58.00, '/images/pizzas/portuguesa.png', TRUE, FALSE, 4)
ON CONFLICT (codigo) DO NOTHING^^^

-- Produtos iniciais da categoria Sobremesas.
INSERT INTO public.produtos (categoria_id, codigo, nome, descricao, valor, imagem, ativo, destaque, ordem_exibicao) VALUES
((SELECT id FROM public.categorias WHERE slug = 'sobremesas'), 'SOB-001', 'Tiramisu', NULL, 24.00, '/images/sobremessas/tiramisu.png', TRUE, FALSE, 1),
((SELECT id FROM public.categorias WHERE slug = 'sobremesas'), 'SOB-002', 'Panna Cotta com calda de frutas vermelhas', NULL, 22.00, '/images/sobremessas/panna-cotta.png', TRUE, TRUE, 2),
((SELECT id FROM public.categorias WHERE slug = 'sobremesas'), 'SOB-003', 'Petit Gateau com sorvete', NULL, 26.00, '/images/sobremessas/petit-gateau.png', TRUE, FALSE, 3),
((SELECT id FROM public.categorias WHERE slug = 'sobremesas'), 'SOB-004', 'Gelato Italiano', NULL, 18.00, '/images/sobremessas/gelato-italiano.png', TRUE, FALSE, 4)
ON CONFLICT (codigo) DO NOTHING^^^

-- Produtos iniciais da categoria Bebidas.
INSERT INTO public.produtos (categoria_id, codigo, nome, descricao, valor, imagem, ativo, destaque, ordem_exibicao) VALUES
((SELECT id FROM public.categorias WHERE slug = 'bebidas'), 'BEB-001', 'Agua mineral', NULL, 6.00, '/images/bebidas/agua-da-pedra.png', TRUE, FALSE, 1),
((SELECT id FROM public.categorias WHERE slug = 'bebidas'), 'BEB-002', 'Refrigerante lata', NULL, 8.00, '/images/bebidas/coca-cola-lata.png', TRUE, FALSE, 2),
((SELECT id FROM public.categorias WHERE slug = 'bebidas'), 'BEB-003', 'Suco natural', NULL, 12.00, '/images/bebidas/suco-natural.png', TRUE, FALSE, 3),
((SELECT id FROM public.categorias WHERE slug = 'bebidas'), 'BEB-004', 'Cafe espresso', NULL, 7.00, '/images/bebidas/cafe-espresso.png', TRUE, FALSE, 4)
ON CONFLICT (codigo) DO NOTHING^^^

-- Usuários administrativos não recebem seed por segurança.
-- Quando o login for criado, a senha deve ser salva como hash usando BCrypt ou algoritmo equivalente.
