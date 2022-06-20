<?php

class User
{
    private int $codigo;

    public function __construct(int $codigo)
    {
        $this->codigo = $codigo;
    }

    public function getCodigo(): int
    {
        return $this->codigo;
    }
    
    
}
