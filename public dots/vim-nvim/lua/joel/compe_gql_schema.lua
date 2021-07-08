local compe = require 'compe'
local Source = {}

function Source.new() return setmetatable({}, {__index = Source}) end

function Source.get_metadata(self)
    return {
        priority = 1000,
        menu = '[GQL Schema]',
	-- @TODOUA: setting or check if you're in a GraphQL project
        filetypes = vim.g.compe_gql_fts or {"graphql", "javascript"}
    }
end

function Source.determine(self, context) return compe.helper.determine(context) end

-- @TODOUA: call zsh command to generate comp file on-demand
-- @TODOUA: possibly go from schema → comp text file in here
-- @TODOUA: possibly go from schema → comp with no intermediate file
-- @TODOUA: possibly call rover to generate updated schema prior to above
-- @TODOUA: make file path a variable & check for it
-- USAGE: 
-- Get your schema via introspection w/ this or equivalent:
-- `rover graph introspect https://api.mygql.io/graphql > ~/path/to/gql-schema.graphql`
-- Then run `zsh ~/path/to/create-gql-schema-compe-source.zsh`
-- Change the file path below to the file that gets spit out
-- Planning to automate all or most of this other than introspection
function Source.complete(self, context)
    local items = {}
    for line in io.lines("/Users/joel/work/gqls/gql-comp-src.text") do
        table.insert(items, {word = line, kind = ''})
    end
    context.callback({
        items = items
    })
end
-- @TODOUA: use this or load generic info into line items
-- function Source.documentation(self, context)
--     local doc = {
--         Dodgers = 'Documentation for Dodgers'
--     }

--     -- will show the current selected item documentation
--     context.callback({doc[context.completed_item.word]})
-- end

function Source.confirm(self, context)
    -- to special stuff here like snippets expansion for example
end

-- Register your custom source.
compe.register_source('gql_schema', Source)
