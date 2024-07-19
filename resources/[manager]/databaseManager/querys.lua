local querys = {
    ["account"] = {
        [[CREATE TABLE IF NOT EXISTS `account` (
            `id` int(10) NOT NULL,
            `username` VARCHAR(10) NOT NULL,
            `password` VARCHAR(50) NOT NULL,
            `email` VARCHAR(100) NOT NULL,
            `register_date` DATETIME DEFAULT NULL,
            `last_login` DATETIME DEFAULT NULL,
            PRIMARY KEY (id)
        );]],
    },
    ["characters"] = {
        [[
            CREATE TABLE IF NOT EXISTS characters (
                id int(10) NOT NULL,
                account_id int(10) NOT NULL,
                character_name varchar(20) NOT NULL,
                position varchar(100) NOT NULL,
                interior int(10) NOT NULL DEFAULT 0,
                dimension int(10) NOT NULL DEFAULT 0,
                health float NOT NULL DEFAULT 100,
                armor float NOT NULL DEFAULT 0,
                money bigint NOT NULL DEFAULT 0,
                gender int(1) DEFAULT 0,
                PRIMARY KEY (id)
            );
        ]]
    }
}

-- function generateQuerys(conn)
--     if conn then
--         for table, query in pairs(querys) do
--             for i, v in ipairs(query) do
--                 local result = dbExec(conn, v)
--                 if result then
--                     outputDebugString("Query executed successfully")
--                 else
--                     outputDebugString("Query failed")
--                 end
--             end
--         end
--     end
-- end