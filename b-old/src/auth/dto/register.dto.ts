import { IsEmail, IsString, MinLength, IsOptional, IsEnum } from 'class-validator';
import { RoleType } from '@prisma/client';

export class RegisterDto {
  @IsEmail()
  email: string;

  @IsString()
  @MinLength(6)
  password: string;

  @IsString()
  fullName: string;

  @IsOptional()
  @IsEnum(RoleType)
  initialRole?: RoleType; // Rôle principal choisi à l'inscription
}