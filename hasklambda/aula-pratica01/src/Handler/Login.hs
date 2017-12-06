{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Login where

import Import
import Database.Persist.Postgresql
import Text.Cassius

formLogin :: Form (Text, Text)
formLogin = renderDivs $ (,) 
        <$> areq emailField "Email: " Nothing
        <*> areq passwordField "Senha: " Nothing
        --aopt para os campos opcionais como o complemento

getLoginR :: Handler Html
getLoginR = do
    (widget,enctype) <- generateFormPost formLogin
    defaultLayout $ do
        addStylesheet $ StaticR css_materialize_css
        addStylesheetRemote "https://fonts.googleapis.com/icon?family=Material+Icons"
        addScript $ StaticR js_jquery_js
        addScript $ StaticR js_materialize_js
        addScript $ StaticR js_init_js
        toWidget $ $(cassiusFile "templates/estilo/estilo.cassius")
        $(whamletFile "templates/html/login.hamlet")
        
autenticar :: Text -> Text -> HandlerT App IO (Maybe (Entity Cliente))
autenticar email senha = runDB $ selectFirst [ClienteEmail ==. email
                                             ,ClienteSenha ==. senha] []

postLoginR :: Handler Html
postLoginR = do
    ((res,_),_) <- runFormPost formLogin
    case res of 
        FormSuccess (email,senha) -> do 
            talvezCliente <- autenticar email senha 
            case talvezCliente of 
                Nothing -> do 
                    setMessage [shamlet| 
                        <p> 
                            Login ou senha invalido 
                    |]
                    redirect LoginR
                Just (Entity clid (Cliente nome sobrenome cpf email _ telefone endereco numero complemento cidade estado)) -> do 
                    setSession "_CLI" (pack (show $ Cliente nome sobrenome cpf email "" telefone endereco numero complemento cidade estado))
                    redirect (CardapioR)
        _ -> redirect HomeR

postLogoutR :: Handler Html
postLogoutR = do 
    deleteSession "_CLI"
    redirect HomeR