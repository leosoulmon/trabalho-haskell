{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ViewPatterns #-}
{-# LANGUAGE QuasiQuotes #-}

module Foundation where

import Import.NoFoundation
import Database.Persist.Sql (ConnectionPool, runSqlPool)
import Yesod.Core.Types     (Logger)

data App = App
    { appSettings    :: AppSettings
    , appStatic      :: Static 
    , appConnPool    :: ConnectionPool 
    , appHttpManager :: Manager
    , appLogger      :: Logger
    }

mkYesodData "App" $(parseRoutesFile "config/routes")

instance Yesod App where
    makeLogger = return . appLogger
    -- authRoute _ = Just LoginR
    -- isAuthorized HomeR _ = return Authorized
    -- isAuthorized LoginR _ = return Authorized
    -- isAuthorized CadUsuarioR _ = return Authorized
    -- isAuthorized AdminR _ = ehAdmin
    -- isAuthorized _ _ = ehUsuario
    
    
-- VALIDACAO DE USUARIO
-- ehUsuario :: Handler AuthResult
-- ehUsuario = do 
--     sess <- lookupSession "_USR"
--     case sess of 
--         Nothing -> return AuthenticationRequired
--         Just _ -> return Authorized

-- ehAdmin :: Handler AuthResult
-- ehAdmin = do 
--     sess <- lookupSession "_USR"
--     usr <- return $ fmap (P.read . unpack) sess :: Handler (Maybe Usuario)
--     case usr of 
--         Nothing -> return AuthenticationRequired
--         Just (Usuario "admin" _ _ _) -> return Authorized
--         Just _ -> return $ Unauthorized "VC NAO TEM PERMISSAO"


type Form a = Html -> MForm Handler (FormResult a, Widget)

instance YesodPersist App where
    type YesodPersistBackend App = SqlBackend
    runDB action = do
        master <- getYesod
        runSqlPool action $ appConnPool master

instance RenderMessage App FormMessage where
    renderMessage _ _ = defaultFormMessage

instance HasHttpManager App where
    getHttpManager = appHttpManager
