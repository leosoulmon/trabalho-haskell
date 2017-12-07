{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Cliente where

import Import
import Network.HTTP.Types.Status
import Database.Persist.Postgresql
import Text.Cassius
import qualified Prelude as P

formCliente :: Form Cliente 
formCliente = renderDivs $ Cliente 
    <$> areq textField "Nome: " Nothing
    <*> areq textField "Sobrenome: " Nothing
    <*> areq textField "CPF: " Nothing
    <*> areq textField "Email: " Nothing
    <*> areq textField "Senha: " Nothing
    <*> areq textField "Telefone: " Nothing
    <*> areq textField "Endereço: " Nothing
    <*> areq intField "Número: " Nothing
    <*> aopt textField "Complemento: " Nothing
    <*> areq textField "Cidade: " Nothing
    <*> areq textField "Estado: " Nothing
        
getCadastrarClienteR :: Handler Html
getCadastrarClienteR = do
    sess <- lookupSession "_CLI"
    talvezUsuario <- return $ fmap (P.read . unpack) sess :: HandlerT App IO (Maybe Cliente)
    (widget,enctype) <- generateFormPost formCliente
    defaultLayout $ do
        addStylesheet $ StaticR css_materialize_css
        addStylesheetRemote "https://fonts.googleapis.com/icon?family=Material+Icons"
        addScript $ StaticR js_jquery_js
        addScript $ StaticR js_materialize_js
        addScript $ StaticR js_init_js
        toWidget $ $(cassiusFile "templates/estilo/estilo.cassius")
        $(whamletFile "templates/html/header.hamlet")
        $(whamletFile "templates/html/cadastrar.hamlet")
        $(whamletFile "templates/html/footer.hamlet")

postCadastrarClienteR :: Handler Html
postCadastrarClienteR = do 
    ((result,_),_) <- runFormPost formCliente
    case result of
        FormSuccess cliente -> do 
            clienteid <- runDB $ insert cliente 
            --clienteid <- runDB $ insert serie 
            redirect (LoginR)