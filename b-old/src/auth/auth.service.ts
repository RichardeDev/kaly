import { Injectable, ConflictException, UnauthorizedException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcryptjs';
import { RegisterDto } from './dto/register.dto';

@Injectable()
export class AuthService {
  constructor(
    private prisma: PrismaService,
    private jwtService: JwtService,
  ) {}

  async register(registerDto: RegisterDto) {
    const { email, password, fullName, initialRole } = registerDto;

    // Vérifier si l'user existe
    const existingUser = await this.prisma.user.findUnique({ 
      where: { email } 
    });
    
    if (existingUser) {
      throw new ConflictException('Cet email est déjà utilisé');
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Créer l'utilisateur - SYNTAXE CORRIGÉE
    const user = await this.prisma.user.create({
      data: {
        email,
        password: hashedPassword,
        fullName,
        currentRole: initialRole || 'USER_SIMPLE',
        roles: {
          create: {
            role: initialRole || 'USER_SIMPLE',
          },
        },
      },
      include: { 
        roles: true 
      },
    });

    return this.generateToken(user);
  }

  async validateUser(email: string, password: string): Promise<any> {
    const user = await this.prisma.user.findUnique({ where: { email } });
    if (user && (await bcrypt.compare(password, user.password))) {
      const { password, ...result } = user;
      return result;
    }
    return null;
  }

  async login(user: any) {
    return this.generateToken(user);
  }

  private generateToken(user: any) {
    const payload = { 
      email: user.email, 
      sub: user.id, 
      currentRole: user.currentRole 
    };
    return {
      access_token: this.jwtService.sign(payload),
      user: {
        id: user.id,
        email: user.email,
        fullName: user.fullName,
        currentRole: user.currentRole,
        roles: user.roles.map((r) => r.role),
      },
    };
  }
}