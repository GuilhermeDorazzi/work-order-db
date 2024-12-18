SELECT 
    EVENT_SCHEMA,
    EVENT_NAME,
    STATUS,
    EVENT_DEFINITION,
    LAST_ALTERED,
    LAST_EXECUTED,
    STARTS,
    ENDS,
    INTERVAL_VALUE,
    INTERVAL_FIELD
FROM 
    INFORMATION_SCHEMA.EVENTS
WHERE 
    EVENT_NAME = 'geracao_automatica_salario';
    