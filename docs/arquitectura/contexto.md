# Comercio Electrónico para Pequeños Comercios

## ¿Qué parte del flujo de compra es síncrona y cuál asíncrona?

La parte síncrona del proceso incluye las acciones que deben completarse antes de responder al usuario. Cuando un cliente confirma una compra, el sistema valida la disponibilidad de los productos, crea la orden y reserva o descuenta el inventario correspondiente. Una vez realizadas estas acciones, se devuelve una respuesta inmediata indicando que el pedido fue registrado correctamente.

La parte asíncrona incluye procesos que pueden ejecutarse después de responder al usuario. Entre ellos se encuentran el procesamiento del pago, el envío de correos de confirmación, la actualización de reportes y otras tareas secundarias. Esto permite mejorar el rendimiento y evitar tiempos de espera innecesarios.

## ¿Cómo evitan vender productos que ya no existen en inventario si el catálogo está en caché?

La caché se utiliza únicamente para acelerar la consulta de productos y reducir la carga sobre la base de datos. Sin embargo, el inventario real siempre se valida en la base de datos al momento de confirmar la compra.

Cuando un usuario realiza un pedido, el sistema verifica nuevamente la cantidad disponible y actualiza el inventario mediante una operación transaccional. Si el stock ya no es suficiente, la compra se rechaza. De esta manera se evita la sobreventa incluso cuando la información mostrada en el catálogo proviene de una caché.

## ¿Qué ve el usuario si la pasarela de pagos tarda 30 segundos?

El usuario no debe esperar 30 segundos a que finalice la transacción. En su lugar, el sistema crea la orden inmediatamente y muestra un mensaje indicando que el pago está siendo procesado.

La orden queda registrada con un estado como "Pendiente de pago", mientras un proceso en segundo plano se comunica con la pasarela de pagos. Cuando se recibe una respuesta, el estado de la orden se actualiza a "Confirmada" o "Rechazada" según el resultado de la transacción.

De esta forma, la experiencia del usuario es más rápida y la aplicación puede manejar mejor los tiempos de respuesta de sistemas externos.
