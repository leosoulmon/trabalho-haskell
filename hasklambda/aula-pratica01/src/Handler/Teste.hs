{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Teste where

import Import
kamehameha :: Widget
kamehameha = [whamlet|
                    <h1>
                        Eu sou um pedaço de código aaaaaaaaaaaaaaaaaaaaa!!!!!
            |]
            
            
--Linkando uma imagem | @{} StaticR e o esquema de arquivo | pasta_nome_extensao
-- <img src=@{StaticR img_ppgs_jpg}>
            
getTesteR :: Handler Html
getTesteR = do
    defaultLayout $ do
        toWidgetHead $  [julius|
                            function alo(){
                                alert("alo");
                            }
                        |]
        toWidget $  [cassius|
                        button
                            color: white
                            background-color: black
                    |]
        [whamlet|
            <h1>
                ^{kamehameha}
            <a href=@{HomeR "leo"}>
                pagina alo
            <button onclick="alo()">
                alooo
        |]