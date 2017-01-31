# Instance Profiles

## Introducción

Se usan para asignarle credenciales de AWS de forma segura a una instancia de Amazon. Se puede usar tanto en instancias 
aisladas de EC2 como ambientes de Elastic Beanstalk, funciones Lambda, etc.

La ventaja que trae usar Instance Profiles es que no hace falta agregar credenciales de AWS a las variables de ambiente.
De esta forma, cuando queremos usar el SDK no hace falta instanciarlo de esta forma:

`ec2 = Aws::EC2::Client.new(region: region_name, credentials: credentials)`

sino que podemos directamente instanciarlo de esta forma:

`ec2 = Aws::EC2::Client.new(region: region_name)`

## Configuración

Para poder usar Instance Roles, lo primero que hay que hacer es crear dicho ROL en IAM. Para esto, dirigirse a la [sección de 
IAM](https://console.aws.amazon.com/iam/home?region=us-east-1) en la consola de AWS.

Una vez ahí, ingresar a Roles -> Create New Role.

1. Ingresar el nombre del rol. Debe ser un nombre descriptivo y representativo.
2. Select Role Type: Elegir *Amazon EC2*
3. Elegir los permisos que queremos darle a la instancia
  * Si es una instancia de un ambiente de Elastic Beanstalk agregar:
    * AWSElasticBeanstalkWebTier
    * AWSElasticBeanstalkMulticontainerDocker
    * AWSElasticBeanstalkWorkerTier
    
Una vez creado el ROL hay que crear la Policy que va a reglar los accessos de dicha instancia. Para esto, dentro de IAM,
hay que ir a Policies -> Create Policy. Se recomienda usar el Policy Generator para generar las policies de forma sencilla.
Se pueden agregar accessos a varios recursos en una misma policy.

Finalmente hay que asociar la policy recién creada con el ROL creado anteriormente. Para esto:
1. Buscar el ROL
2. Hacer click en Attach Policy
3. Buscar la policy recin generada y asociarla.

Con esto la instancia ya va a tener permisos para realizar las acciones que la policy permita. Si en el futuro se quieren 
agregar permisos, basta con editar la policy.
