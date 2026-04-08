import { ArgumentsHost, Catch, ConflictException, ExceptionFilter, NotFoundException } from '@nestjs/common';
import { Prisma } from '@prisma/client';

@Catch(Prisma.PrismaClientKnownRequestError)
export class PrismaClientExceptionFilter implements ExceptionFilter {
  catch(exception: Prisma.PrismaClientKnownRequestError, host: ArgumentsHost) {
    const response = host.switchToHttp().getResponse();

    if (exception.code === 'P2002') {
      throw new ConflictException('Resource already exists');
    }

    if (exception.code === 'P2025') {
      throw new NotFoundException('Resource not found');
    }

    response.status(500).json({
      statusCode: 500,
      message: 'Internal server error',
    });
  }
}
